function Get-BricksetSet {
<#
    .SYNOPSIS
    Get Brickset Sets
    
    .DESCRIPTION
    Get Brickset Sets

    .PARAMETER Theme
    Brickset Theme

    .PARAMETER Subtheme
    Brickset Subtheme

    .PARAMETER Year
    Year

    .PARAMETER SetNumber
    Lego Set Number in the format {number}-{variant}, e.g. 6905-1

    .PARAMETER OrderBy
    Specify Sort Order

    .INPUTS
    System.String.
    System.Int

    .OUTPUTS
    Brickset.sets

    .EXAMPLE
    Get-BricksetSet -Theme 'Indiana Jones' -Subtheme 'Temple of Doom'

    .EXAMPLE
    Get-BricksetSet -Theme 'Indiana Jones' -Year 2009

    .EXAMPLE
    Get-BricksetSet -SetNumber '7199-1'

    .EXAMPLE
    Get-BricksetSet -Theme 'Indiana Jones' -OrderBy Pieces
#>
[CmdletBinding()][OutputType('Brickset.sets')]

    Param
    (

    [parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String]$Theme,

    [parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String]$Subtheme,

    [parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    $Year,

    [parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String]$SetNumber,

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

        # --- Make the Webservice Call
        $BricksetConnection.WebService.getSets($BricksetConnection.APIKey,$null,$null,$Theme,$Subtheme,$SetNumber,$Year,$null,$null,$OrderBy,$PageSize,$null,$null)
    }
    catch [Exception]{
            
        throw
    }
}