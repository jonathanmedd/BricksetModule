function Get-BricksetSetDetailed {
<#
    .SYNOPSIS
    Get Brickset Set Detailed
    
    .DESCRIPTION
    Get Brickset Set with detailed info

    .PARAMETER SetId
    Brickset SetId (not the Lego Set Number)

    .INPUTS
    System.String.

    .OUTPUTS
    Brickset.sets

    .EXAMPLE
    Get-BricksetSetDetailed -SetId 6905

    .EXAMPLE
    Get-BricksetSet -Theme 'Indiana Jones' | Get-BricksetSetDetailed
#>
[CmdletBinding()][OutputType('Brickset.sets')]

    Param
    (

    [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$SetId
    )

    begin {

        # --- Check for the presence of $Global:BricksetConnection
        xCheckGlobalBricksetConnection
    }
    process {
        
        try {
        
            $BricksetConnection.WebService.getSet($BricksetConnection.APIKey,$null,$SetId)
        }
        catch [Exception]{
            
            throw 
        }
    }
}