function Get-BricksetSetWanted {
<#
    .SYNOPSIS
    Get Brickset Sets Wanted
    
    .DESCRIPTION
    Get Brickset Sets Wanted

    .PARAMETER OrderBy
    Specify Sort Order

    .PARAMETER PageSize
    Specify how many records to return

    .INPUTS
    System.String.
    System.Int.

    .OUTPUTS
    Brickset.sets

    .EXAMPLE
    Get-BricksetSetWanted -OrderBy Pieces
#>
[CmdletBinding()][OutputType('Brickset.sets')]

    Param
    (

    [parameter(Mandatory=$false)]
    [ValidateSet('Number','YearFrom','Pieces','Minifigs','Rating','UKRetailPrice','USRetailPrice','CARetailPrice','EURetailPrice','Theme','Subtheme','Name','Random')]
    [String]$OrderBy,

    [parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [Int]$PageSize = 1000
    )
    
    try {

        # --- Check for the presence of $Global:BricksetConnection
        xCheckGlobalBricksetConnection
    
        # --- Check for the UserHash
        xCheckUserHash

        # --- Make the Webservice Call
        $BricksetConnection.WebService.getSets($BricksetConnection.APIKey,$BricksetConnection.UserHash,$null,$null,$null,$null,$null,$null,1,$OrderBy,$PageSize,$null,$null)
    }
    catch [Exception]{
            
        throw
    }
}