function Disconnect-Brickset {
<#
    .SYNOPSIS
    Disconnect from the Brickset API

    .DESCRIPTION
    Disconnect from the Brickset API by removing the global BricksetConnection variable from PowerShell

    .EXAMPLE
    Disconnect-Brickset

    .EXAMPLE
    Disconnect-Brickset -Confirm:$false
#>
[CmdletBinding(SupportsShouldProcess,ConfirmImpact="High")]

    Param ()

    # --- Check for the presence of $Script:BricksetConnection
    xCheckGlobalBricksetConnection

    if ($PSCmdlet.ShouldProcess($Script:BricksetConnection.url)){

        try {

            Write-Verbose -Message "Removing BricksetConnection Script Variable"
            Remove-Variable -Name BricksetConnection -Scope Script -Force -ErrorAction SilentlyContinue
        }
        catch [Exception]{

            throw

        }
    }
}