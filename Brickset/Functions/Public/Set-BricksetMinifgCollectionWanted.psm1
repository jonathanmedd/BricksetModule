function Set-BricksetMinifgCollectionWanted {
<#
    .SYNOPSIS
    Set a Brickset Minifg to Wanted status
    
    .DESCRIPTION
    Set a Brickset Minfig to Wanted status.

    .PARAMETER MinifgNumber
    Brickset MinifgNumber

    .INPUTS
    System.String

    .OUTPUTS
    None

    .EXAMPLE
    Set-BricksetMinifgCollectionWanted -MinifgNumber sw705
#>
[CmdletBinding(SupportsShouldProcess,ConfirmImpact="High")]

    Param
    (
    [parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$MinifgNumber
    )
    
    try {

        # --- Check for the presence of $Global:BricksetConnection
        xCheckGlobalBricksetConnection

        # --- Check for the UserHash
        xCheckUserHash

        # --- Make the Webservice Call
        if ($PSCmdlet.ShouldProcess($MinifgNumber)){

            $BricksetConnection.WebService.setMinifigCollection($BricksetConnection.APIKey, $BricksetConnection.UserHash, $MinifgNumber, $null, 1)
        }
    }
    catch [Exception]{
            
        throw
    }
}