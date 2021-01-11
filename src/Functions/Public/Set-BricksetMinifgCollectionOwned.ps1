function Set-BricksetMinifgCollectionOwned {
    <#
    .SYNOPSIS
    Set a Brickset Minifg to Owned status

    .DESCRIPTION
    Set a Brickset Minfig to Owned status. Include the number of sets owned.

    .PARAMETER MinifgNumber
    Brickset MinifgNumber

    .PARAMETER QtyOwned
    Quantity Owned

    .INPUTS
    System.String
    System.Number

    .OUTPUTS
    None

    .EXAMPLE
    Set-BricksetMinifgCollectionOwned -MinifgNumber sw705 -QtyOwned 1
#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]

    Param
    (
        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$minifigNumber,

        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Int]$qtyOwned
    )

    try {

        # --- Check for the presence of $Global:BricksetConnection
        xCheckGlobalBricksetConnection

        # --- Check for the UserHash
        xCheckUserHash

        if ($PSCmdlet.ShouldProcess($minifigNumber)) {

            # - Prepare the JSON params
            $jsonParams = [PSCustomObject] @{

                owned = '1'
                qtyOwned = $qtyOwned
            }

            $stringParam = $jsonParams | ConvertTo-Json -Compress

            Write-Verbose "jsonParams are: $stringParam"

            # --- Make the REST Call
            $body = @{
                apiKey   = $Script:BricksetConnection.apiKey
                userHash = $Script:BricksetConnection.userHash
                params   = $stringParam
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