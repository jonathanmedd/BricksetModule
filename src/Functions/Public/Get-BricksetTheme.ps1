﻿function Get-BricksetTheme {
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

        # --- Make the Webservice Call
        $body = @{
            apiKey = $Script:BricksetConnection.apiKey
        }

        Invoke-BricksetRestMethod -Method POST -URI '/getThemes' -Body $body
    }
    catch [Exception]{

        throw
    }
}