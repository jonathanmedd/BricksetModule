function Get-BricksetCollectionUserNotes {
<#
    .SYNOPSIS
    Get all a user's set notes.
    
    .DESCRIPTION
    Get all a user's set notes.

    .INPUTS
    None

    .OUTPUTS
    Brickset.userNotes

    .EXAMPLE
    Get-BricksetCollectionUserNotes
#>
[CmdletBinding()][OutputType('Brickset.userNotes')]

    Param
    (

    )
    
    try {

        # --- Check for the presence of $Global:BricksetConnection
        xCheckGlobalBricksetConnection
    
        # --- Check for the UserHash
        xCheckUserHash

        # --- Make the Webservice Call
        $BricksetConnection.WebService.getUserNotes($BricksetConnection.APIKey,$BricksetConnection.UserHash)
    }
    catch [Exception]{
            
        throw
    }
}