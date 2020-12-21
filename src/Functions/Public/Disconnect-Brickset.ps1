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

    # --- Test for existing connection to vRA
    if (-not $Global:BricksetConnection){

        throw "Brickset Connection variable does not exist. Please run Connect-Brickset first to create it"
    }

    if ($PSCmdlet.ShouldProcess($Global:BricksetConnection.WebService)){

        try {

            Write-Verbose -Message "Removing BricksetConnection Global Variable"
            Remove-Variable -Name BricksetConnection -Scope Global -Force -ErrorAction SilentlyContinue

        }
        catch [Exception]{

            throw

        }
    }
}