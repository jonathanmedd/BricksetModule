function Get-BricksetSetReview {
<#
    .SYNOPSIS
    Get Brickset Set Reviews
    
    .DESCRIPTION
    Get Brickset Set Reviews
    
    .PARAMETER SetId
    Brickset SetId (not the Lego Set Number)

    .INPUTS
    System.String.

    .OUTPUTS
    Brickset.reviews

    .EXAMPLE
    Get-BricksetSetReview -SetId 6905

    .EXAMPLE
    Get-BricksetSet -Theme 'Indiana Jones' | Get-BricksetSetReview
#>
[CmdletBinding()][OutputType('Brickset.reviews')]

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
        
            $BricksetConnection.WebService.getReviews($BricksetConnection.APIKey,$SetId)
        }
        catch [Exception]{
            
            throw
        }
    }
}