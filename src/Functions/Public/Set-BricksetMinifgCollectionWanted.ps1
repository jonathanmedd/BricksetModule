function Set-BricksetMinifgCollectionWanted {
    <#
    .SYNOPSIS
    Set a Brickset Minifg to Wanted status

    .DESCRIPTION
    Set a Brickset Minfig to Wanted status.

    .PARAMETER MinifigNumber
    Brickset MinifigNumber

    .INPUTS
    System.String

    .OUTPUTS
    None

    .EXAMPLE
    Set-BricksetMinifgCollectionWanted -MinifigNumber sw705
#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]

    Param
    (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$minifigNumber
    )

    try {

        # --- Check for the presence of $Script:BricksetConnection
        xCheckScriptBricksetConnection

        # --- Check for the UserHash
        xCheckUserHash

        if ($PSCmdlet.ShouldProcess($MinifigNumber)) {

            # - Prepare the JSON params
            $jsonParams = [PSCustomObject] @{

                want = '1'
            }

            $stringParam = $jsonParams | ConvertTo-Json -Compress

            Write-Verbose "jsonParams are: $stringParam"

            # --- Make the REST Call
            $body = @{
                apiKey        = $Script:BricksetConnection.apiKey
                userHash      = $Script:BricksetConnection.userHash
                params        = $stringParam
                minifigNumber = $minifigNumber
            }

            Write-Verbose "Body is: $($body | ConvertTo-Json -Depth 5)"

            Invoke-BricksetRestMethod -Method POST -URI '/setMinifigCollection' -Body $body
        }
    }
    catch [Exception] {

        throw
    }
}