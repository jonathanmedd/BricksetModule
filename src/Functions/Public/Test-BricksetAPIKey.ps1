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

    param
    (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$apiKey
    )

    try {

        # --- Make the REST Call
        $body = @{
            apiKey = $apiKey
        }

        $contentType = 'application/x-www-form-urlencoded'

        $checkKey = Invoke-RestMethod -Method POST -Uri 'https://brickset.com/api/v3.asmx/checkKey' -ContentType $contentType -body $body

        if ($checkKey.status -eq 'success') {

            Write-Output $true
        }
        else {

            Write-Output $false
        }
    }
    catch [Exception] {

        throw
    }
}