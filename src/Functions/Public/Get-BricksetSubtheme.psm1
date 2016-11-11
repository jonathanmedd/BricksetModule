function Get-BricksetSubtheme {
<#
    .SYNOPSIS
    Get Brickset Subthemes for a given Theme
    
    .DESCRIPTION
    Get Brickset Subthemes for a given Theme
    
    .PARAMETER APIKey
    API Key

    .PARAMETER Theme
    Brickset Theme

    .INPUTS
    System.String.

    .OUTPUTS
    Brickset.subthemes

    .EXAMPLE
    Get-BricksetSubtheme -APIKey 'Tk5C-KTA2-Gw2Q' -Theme 'Indiana Jones'

    .EXAMPLE
    Get-BricksetThemes | Where-Object {$_.Theme -eq 'Indiana Jones'} | Get-BricksetSubtheme -APIKey 'Tk5C-KTA2-Gw2Q'
#>
[CmdletBinding()][OutputType('Brickset.subthemes')]

    Param
    (

    [parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String]$APIKey,

    [parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$Theme
    )
    
begin {

    # --- If $APIKey not supplied, try $Global:BricksetAPIKey

    if (!($PSBoundParameters.ContainsKey('APIKey'))){
            
        try {
    
            Get-Variable BricksetAPIKey | Out-Null
            $APIKey = $BricksetAPIKey
        }
        catch [Exception] {

            throw 'Brickset API Key not specified nor exists in $Global:BricksetAPIKey. Please set this to continue'
        }
    }

    # --- Make the Webservice Call
    if (!($Webservice)){

        $Global:Webservice = New-WebServiceProxy -Uri 'http://brickset.com/api/v2.asmx?WSDL' -Namespace 'Brickset' -Class 'Sets'
    }    
}

process {

    try {

        foreach ($ThemeObject in $Theme){

            $Webservice.getSubthemes($APIKey,$ThemeObject)
        }
    }
    catch [Exception]{
        
        throw "Unable to get Brickset Subthemes for a given Theme"
    }
}
}