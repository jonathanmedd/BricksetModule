function Get-BricksetTheme {
<#
    .SYNOPSIS
    Get Brickset Themes
    
    .DESCRIPTION
    Get Brickset Themes
    
    .INPUTS
    None

    .OUTPUTS
    Brickset.themes

    .EXAMPLE
    Get-BricksetTheme
#>
[CmdletBinding()][OutputType('Brickset.themes')]

    Param
    (

    )    

    try {

        # --- Check for the presence of $Global:BricksetConnection
        xCheckGlobalBricksetConnection

        # --- Make the Webservice Call
        $BricksetConnection.WebService.getThemes($BricksetConnection.APIKey)
    }
    catch [Exception]{
            
        throw
    }
}