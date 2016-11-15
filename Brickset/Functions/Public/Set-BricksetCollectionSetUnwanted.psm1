function Set-BricksetCollectionSetUnwanted {
<#
    .SYNOPSIS
    Set a Brickset Set to Unwanted status
    
    .DESCRIPTION
    Set a Brickset Set to Unwanted status

    .PARAMETER SetId
    Brickset SetId

    .INPUTS
    String

    .OUTPUTS
    None

    .EXAMPLE
    Set-BricksetCollectionSetUnwanted -SetId 26049
#>
[CmdletBinding(SupportsShouldProcess,ConfirmImpact="High")]

    Param
    (
    [parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$SetId

    )
    
    try {

        # --- Check for the presence of $Global:BricksetConnection
        xCheckGlobalBricksetConnection

        # --- Check for the UserHash
        xCheckUserHash

        # --- Make the Webservice Call
        if ($PSCmdlet.ShouldProcess($SetId)){

            $BricksetConnection.WebService.setCollection_wants($BricksetConnection.APIKey, $BricksetConnection.UserHash, $SetId, 0)
        }
    }
    catch [Exception]{
            
        throw
    }
}