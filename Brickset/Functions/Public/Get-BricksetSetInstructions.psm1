function Get-BricksetSetInstructions {
<#
    .SYNOPSIS
    Get Brickset Set Instructions
    
    .DESCRIPTION
    Get Brickset Set Instructions
    
    .PARAMETER APIKey
    API Key

    .PARAMETER SetId
    Brickset SetId (not the Lego Set Number)

    .INPUTS
    System.String.

    .OUTPUTS
    Brickset.instructions

    .EXAMPLE
    Get-BricksetSetInstructions -APIKey 'Tk5C-KTA2-Gw2Q' -SetId 6905

    .EXAMPLE
    Get-BricksetSet -Theme 'Indiana Jones' | Get-BricksetSetInstructions

    .EXAMPLE
    Get-BricksetSet -SetNumber 75055-1 | Get-BricksetSetInstructions | Select-Object -First 1 -ExpandProperty url | Foreach-Object {Invoke-Expression “cmd.exe /C start $_”}

    .EXAMPLE
    Get-BricksetSet -Theme 'Indiana Jones' | Get-BricksetSetInstructions | Select-Object -ExpandProperty url | ForEach-Object {$file = ($_.split('/'))[-1]; Start-BitsTransfer -Source $_ -Destination "C:\Users\jmedd\Documents\$file"}
#>
[CmdletBinding()][OutputType('Brickset.instructions')]

    Param
    (

    [parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String]$APIKey,

    [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$SetId
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
    
        $Webservice.getInstructions($APIKey,$SetId)
    }
    catch [Exception]{
        
        throw "Unable to get Brickset Instructions"
    }
}
}