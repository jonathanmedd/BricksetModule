function Get-BricksetTheme {
<#
    .SYNOPSIS
    Get Brickset Themes
    
    .DESCRIPTION
    Get Brickset Themes
    
    .PARAMETER APIKey
    API Key

    .INPUTS
    System.String.

    .OUTPUTS
    Brickset.themes

    .EXAMPLE
    Get-BricksetTheme -APIKey 'Tk5C-KTA2-Gw2Q'
#>
[CmdletBinding()][OutputType('Brickset.themes')]

    Param
    (

    [parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String]$APIKey
    )    

try {

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

    $Webservice.getThemes($APIKey)
}
catch [Exception]{
        
    throw "Unable to get Brickset Themes"
}
}