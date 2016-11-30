function Get-BricksetMinifigCollectionWanted {
<#
    .SYNOPSIS
    Get Brickset Minifg Collection Wanted
    
    .DESCRIPTION
    Get Brickset Minifg Collection Wanted

    .INPUTS
    None

    .OUTPUTS
    Brickset.minifigCollection

    .EXAMPLE
    Get-BricksetMinifigCollectionWanted
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
        $BricksetConnection.WebService.getMinifigCollection($BricksetConnection.APIKey, $BricksetConnection.UserHash, $null, $null, 1)
    }
    catch [Exception]{
            
        throw
    }
}