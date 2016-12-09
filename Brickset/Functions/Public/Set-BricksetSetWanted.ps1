function Set-BricksetSetWanted {
<#
    .SYNOPSIS
    Set a Brickset Set to Wanted status
    
    .DESCRIPTION
    Set a Brickset Set to Wanted status

    .PARAMETER SetId
    Brickset SetId

    .INPUTS
    String

    .OUTPUTS
    None

    .EXAMPLE
    Set-BricksetSetWanted -SetId 26049
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

            $BricksetConnection.WebService.setCollection_wants($BricksetConnection.APIKey, $BricksetConnection.UserHash, $SetId, 1)
        }
    }
    catch [Exception]{
            
        throw
    }
}