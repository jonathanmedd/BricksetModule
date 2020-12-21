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

    [parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$APIKey
    )    

    try {

        # --- Make the Webservice Call
        $TestWebservice = New-WebServiceProxy -Uri 'http://brickset.com/api/v2.asmx?WSDL' -Namespace 'Brickset' -Class 'Sets'
        $CheckKey = $TestWebservice.checkKey($APIKey)

        if ($CheckKey -eq 'OK'){

            Write-Output $true
        }
        else {

            Write-Output $false
        }
    }
    catch [Exception]{
            
        throw
    }
}