function xCheckScriptBricksetConnection {
<#
    .SYNOPSIS
    Checks for the presence of $Script:BricksetConnection

    .DESCRIPTION
    Checks for the presence of $Script:BricksetConnection

    .INPUTS
    None

    .OUTPUTS
    None

    .EXAMPLE
    xCheckScriptBricksetConnection
#>

[CmdletBinding()]

    Param (

    )
    # --- Test for Brickset Connection
    if (-not $Script:BricksetConnection){

        throw "Brickset Connection variable does not exist. Please run Connect-Brickset first to create it"
    }
}