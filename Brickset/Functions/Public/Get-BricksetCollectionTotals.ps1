function Get-BricksetCollectionTotals {
<#
    .SYNOPSIS
    Get Brickset Collection Totals
    
    .DESCRIPTION
    Get Brickset Collection Totals

    .INPUTS
    None

    .OUTPUTS
    Brickset.collectionTotals

    .EXAMPLE
    Get-BricksetCollectionTotals
#>
[CmdletBinding()][OutputType('Brickset.collectionTotals')]

    Param
    (


    )
    
    try {

        # --- Check for the presence of $Global:BricksetConnection
        xCheckGlobalBricksetConnection

        # --- Check for the UserHash
        xCheckUserHash

        # --- Make the Webservice Call
        $BricksetConnection.WebService.getCollectionTotals($BricksetConnection.APIKey, $BricksetConnection.UserHash)
    }
    catch [Exception]{
            
        throw
    }
}