function Get-BricksetSubtheme {
<#
    .SYNOPSIS
    Get Brickset Subthemes for a given Theme
    
    .DESCRIPTION
    Get Brickset Subthemes for a given Theme
    
    .PARAMETER Theme
    Brickset Theme

    .INPUTS
    System.String.

    .OUTPUTS
    Brickset.subthemes

    .EXAMPLE
    Get-BricksetSubtheme -Theme 'Indiana Jones'

    .EXAMPLE
    Get-BricksetThemes | Where-Object {$_.Theme -eq 'Indiana Jones'} | Get-BricksetSubtheme
#>
[CmdletBinding()][OutputType('Brickset.subthemes')]

    Param
    (

    [parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$Theme
    )
    
    begin {

        # --- Check for the presence of $Global:BricksetConnection
        xCheckGlobalBricksetConnection 
    }

    process {

        try {

            foreach ($ThemeObject in $Theme){

                $BricksetConnection.WebService.getSubthemes($BricksetConnection.APIKey,$ThemeObject)
            }
        }
        catch [Exception]{
            
            throw
        }
    }
}