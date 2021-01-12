function Get-BricksetTheme {
    <#
    .SYNOPSIS
    Get Brickset Themes

    .DESCRIPTION
    Get Brickset Themes

    .INPUTS
    None

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Get-BricksetTheme
#>
    [CmdletBinding()][OutputType('System.Management.Automation.PSObject')]

    param()

    try {

        # --- Check for the presence of $Script:BricksetConnection
        xCheckScriptBricksetConnection

        # --- Make the REST Call
        $body = @{
            apiKey = $Script:BricksetConnection.apiKey
        }

        $response = Invoke-BricksetRestMethod -Method POST -URI '/getThemes' -Body $body

        $response.themes
    }
    catch [Exception] {

        throw
    }
}