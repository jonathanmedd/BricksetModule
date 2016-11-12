function Get-BricksetSet {
<#
    .SYNOPSIS
    Get Brickset Sets
    
    .DESCRIPTION
    Get Brickset Sets
    
    .PARAMETER APIKey
    API Key

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
    Get-BricksetSet -APIKey 'Tk5C-KTA2-Gw2Q' -Theme 'Indiana Jones' -Subtheme 'Temple of Doom'

    .EXAMPLE
    Get-BricksetSet -APIKey 'Tk5C-KTA2-Gw2Q' -Theme 'Indiana Jones' -Year 2009

    .EXAMPLE
    Get-BricksetSet -APIKey 'Tk5C-KTA2-Gw2Q' -SetNumber '7199-1'

    .EXAMPLE
    Get-BricksetSet -APIKey 'Tk5C-KTA2-Gw2Q' -Theme 'Indiana Jones' -OrderBy Pieces
#>
[CmdletBinding()][OutputType('Brickset.sets')]

    Param
    (

    [parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String]$APIKey,

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

    # --- If $APIKey not supplied, try $Global:BricksetAPIKey

    if (!($PSBoundParameters.ContainsKey('APIKey'))){
            
        try {
    
            Get-Variable BricksetAPIKey | Out-Null
            $APIKey = $BricksetAPIKey
        }
        catch [Exception] {

            throw 'Brickset API Key not specified nor exists in $Global:BricksetAPIKey. Please set this to continue'
        }
    }

    # --- Make the Webservice Call
    if (!($Webservice)){

        $Global:Webservice = New-WebServiceProxy -Uri 'http://brickset.com/api/v2.asmx?WSDL' -Namespace 'Brickset' -Class 'Sets'
    }
    
    $Webservice.getSets($APIKey,$null,$null,$Theme,$Subtheme,$SetNumber,$Year,$null,$null,$OrderBy,$PageSize,$null,$null)
}
catch [Exception]{
        
    throw "Unable to get Brickset Sets"
}
}