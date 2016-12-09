function Set-BricksetSetOwned {
<#
    .SYNOPSIS
    Set a Brickset Set to Owned status
    
    .DESCRIPTION
    Set a Brickset Set to Owned status. Include the number of sets owned.

    .PARAMETER SetId
    Brickset SetId

    .PARAMETER QtyOwned
    Quantity Owned

    .INPUTS
    System.String
    System.Number

    .OUTPUTS
    None

    .EXAMPLE
    Set-BricksetSetOwned -SetId 26049 -QtyOwned 1

    .EXAMPLE
    Get-BricksetSet -SetNumber '7199-1' | Set-BricksetSetOwned -QtyOwned 1 -Confirm:$false
#>
[CmdletBinding(SupportsShouldProcess,ConfirmImpact="High")]

    Param
    (
    [parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$SetId,

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
        if ($PSCmdlet.ShouldProcess($SetId)){

            $BricksetConnection.WebService.setCollection($BricksetConnection.APIKey, $BricksetConnection.UserHash, $SetId, $QtyOwned, 0)
        }
    }
    catch [Exception]{
            
        throw
    }
}