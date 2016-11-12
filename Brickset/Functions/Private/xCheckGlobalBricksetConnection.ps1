function Global:xCheckGlobalBricksetConnection {
<#
    .SYNOPSIS
    Checks for the presence of $Global:BricksetConnection

    .DESCRIPTION
    Checks for the presence of $Global:BricksetConnection

    .INPUTS
    None

    .OUTPUTS
    None

    .EXAMPLE
    xCheckGlobalBricksetConnection
#>

[CmdletBinding()]

    Param (

    )
    # --- Test for Brickset Connection
    if (-not $Global:BricksetConnection){

        throw "Brickset Connection variable does not exist. Please run Connect-Brickset first to create it"
    }

    elseif (-not $Global:BricksetConnection.WebService) {

        throw "Brickset Connection variable not populated with a WebService. Please run Connect-Brickset first to populate it"
    }
}