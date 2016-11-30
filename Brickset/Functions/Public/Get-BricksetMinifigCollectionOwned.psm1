function Get-BricksetMinifigCollectionOwned {
<#
    .SYNOPSIS
    Get Brickset Minifg Collection Owned
    
    .DESCRIPTION
    Get Brickset Minifg Collection Owned

    .INPUTS
    None

    .OUTPUTS
    Brickset.minifigCollection

    .EXAMPLE
    Get-BricksetMinifigCollectionOwned
#>
[CmdletBinding()][OutputType('Brickset.minifigCollection')]

    Param
    (

    )
    
    try {

        # --- Check for the presence of $Global:BricksetConnection
        xCheckGlobalBricksetConnection

        # --- Check for the UserHash
        xCheckUserHash

        # --- Make the Webservice Call
        $BricksetConnection.WebService.getMinifigCollection($BricksetConnection.APIKey, $BricksetConnection.UserHash, $null, 1, $null)
    }
    catch [Exception]{
            
        throw
    }
}