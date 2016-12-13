function Set-BricksetSetUserNotes {
<#
    .SYNOPSIS
    Set the User Notes for a Brickset Set.
    
    .DESCRIPTION
    Set the User Notes for a Brickset Set.

    .PARAMETER SetId
    Brickset SetId

    .PARAMETER Notes
    200 chars of text to add to the User Notes field of a Set

    .INPUTS
    System.String

    .OUTPUTS
    None

    .EXAMPLE
    Set-BricksetSetUserNotes  -SetId 26049 -UserNotes "This is one of my favourites"

    .EXAMPLE
    Get-BricksetSet -SetNumber '7199-1' | Set-BricksetSetUserNotes -Notes "This is one of my favourites" -Confirm:$false
#>
[CmdletBinding(SupportsShouldProcess,ConfirmImpact="High")]

    Param
    (
    [parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$SetId,

    [parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$Notes

    )
    
    try {

        # --- Check for the presence of $Global:BricksetConnection
        xCheckGlobalBricksetConnection

        # --- Check for the UserHash
        xCheckUserHash

        # --- Make the Webservice Call
        if ($PSCmdlet.ShouldProcess($SetId)){

            $BricksetConnection.WebService.setCollection_userNotes($BricksetConnection.APIKey, $BricksetConnection.UserHash, $SetId, $Notes)
        }
    }
    catch [Exception]{
            
        throw
    }
}