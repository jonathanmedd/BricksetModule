function Global:xCheckUserHash{
<#
    .SYNOPSIS
    Checks for the presence of $Global:BricksetConnection.UserHash

    .DESCRIPTION
    Checks for the presence of $Global:BricksetConnection.UserHash

    .INPUTS
    None

    .OUTPUTS
    None

    .EXAMPLE
    xCheckUserHash
#>

[CmdletBinding()]

    Param (

    )
    # --- Test for Brickset Connection
    if (-not $Global:BricksetConnection.UserHash){

        throw "Brickset UserHash created from your Brickset login credentials does not exist. Please run Connect-Brickset first to create it"
    }
}