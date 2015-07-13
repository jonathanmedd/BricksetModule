function Test-BricksetAPIKey {
<#
    .SYNOPSIS
    Test the Brickset API Key
    
    .DESCRIPTION
    Test the Brickset API Key
    
    .PARAMETER APIKey
    API Key

    .INPUTS
    System.String.

    .OUTPUTS
    System.Boolean

    .EXAMPLE
    Test-BricksetAPIKey -APIKey 'Tk5C-KTA2-Gw2Q'
#>
[CmdletBinding()][OutputType('System.Boolean')]

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

    $CheckKey = $Webservice.checkKey($APIKey)

    if ($CheckKey -eq 'OK (v2)'){

        Write-Output $true
    }
    else {

        Write-Output $false
    }
}
catch [Exception]{
        
    throw "Unable to test Brickset API Key"
}
}