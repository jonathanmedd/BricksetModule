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
[CmdletBinding(SupportsShouldProcess,ConfirmImpact="High")]

    Param
    (
    [parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$MinifgNumber,

    [parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [Int]$QtyOwned

    )
    
    try {

        # --- Check for the presence of $Global:BricksetConnection
        xCheckGlobalBricksetConnection

        # --- Check for the UserHash
        xCheckUserHash

        # --- Make the Webservice Call
        if ($PSCmdlet.ShouldProcess($MinifgNumber)){

            $BricksetConnection.WebService.setMinifigCollection($BricksetConnection.APIKey, $BricksetConnection.UserHash, $MinifgNumber, $QtyOwned, 0)
        }
    }
    catch [Exception]{
            
        throw
    }
}