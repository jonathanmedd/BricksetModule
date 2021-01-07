function Get-BricksetTheme {
<#
    .SYNOPSIS
    Get Brickset Themes

    .DESCRIPTION
    Get Brickset Themes

    .INPUTS
    None

    .OUTPUTS
    Brickset.themes

    .EXAMPLE
    Get-BricksetTheme
#>
[CmdletBinding()][OutputType('Brickset.themes')]

    param()

    try {

        # --- Check for the presence of $Global:BricksetConnection
        xCheckGlobalBricksetConnection

        # --- Make the REST Call
        $body = @{
            apiKey = $Script:BricksetConnection.apiKey
        }

        $response = Invoke-BricksetRestMethod -Method POST -URI '/getThemes' -Body $body

        $response.themes
    }
    catch [Exception]{

        throw
    }
}