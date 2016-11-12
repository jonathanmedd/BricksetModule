function Get-BricksetYear {
<#
    .SYNOPSIS
    Get Brickset Years for a given Theme
    
    .DESCRIPTION
    Get Brickset Years for a given Theme
    
    .PARAMETER Theme
    Brickset Theme

    .INPUTS
    System.String.

    .OUTPUTS
    Brickset.years

    .EXAMPLE
    Get-BricksetYear -Theme 'Indiana Jones'

    .EXAMPLE
    Get-BricksetThemes | Where-Object {$_.Theme -eq 'Indiana Jones'} | Get-BricksetYear
#>
[CmdletBinding()][OutputType('Brickset.years')]

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

                $BricksetConnection.WebService.getYears($BricksetConnection.APIKey,$ThemeObject)
            }
        }
        catch [Exception]{
            
            throw
        }
    }
}