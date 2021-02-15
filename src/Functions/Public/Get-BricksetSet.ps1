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

    .PARAMETER PageSize
    Specify how many records to return

    .INPUTS
    System.String.
    System.Int

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Get-BricksetSet -Theme 'Indiana Jones' -Subtheme 'Temple of Doom'

    .EXAMPLE
    Get-BricksetSet -Theme 'Indiana Jones' -Year 2009

    .EXAMPLE
    Get-BricksetSet -SetNumber '7199-1'

    .EXAMPLE
    Get-BricksetSet -Theme 'Indiana Jones' -OrderBy Pieces
#>
    [CmdletBinding()][OutputType('System.Management.Automation.PSObject')]

    Param (

        [parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$theme,

        [parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$subTheme,

        [parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        $year,

        [parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$setNumber,

        [parameter(Mandatory = $false)]
        [ValidateSet('Number', 'YearFrom', 'Pieces', 'Minifigs', 'Rating', 'UKRetailPrice', 'USRetailPrice', 'CARetailPrice', 'DERetailPrice', 'FRRetailPrice',
            'UKPricePerPiece', 'USPricePerPiece', 'CAPricePerPiece', 'DEPricePerPiece', 'FRPricePerPiece', 'Theme', 'Subtheme', 'Name', 'Random', 'QtyOwned', 'OwnCount', 'WantCount', 'UserRating', 'CollectionID')]
        [String]$orderBy,

        [parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int]$pageSize = 500
    )

    begin {

        # --- Check for the presence of $Script:BricksetConnection
        xCheckScriptBricksetConnection
    }

    process {

        try {

            # - Prepare the JSON params
            $jsonParams = [PSCustomObject] @{

                pageSize = $pageSize
            }

            if ($PSBoundParameters.ContainsKey('theme')) {

                $jsonParams | Add-Member -MemberType NoteProperty -Name 'theme' -Value $theme
            }
            if ($PSBoundParameters.ContainsKey('subTheme')) {

                $jsonParams | Add-Member -MemberType NoteProperty -Name 'subtheme' -Value $subTheme
            }
            if ($PSBoundParameters.ContainsKey('year')) {

                $jsonParams | Add-Member -MemberType NoteProperty -Name 'year' -Value $year
            }
            if ($PSBoundParameters.ContainsKey('setNumber')) {

                $jsonParams | Add-Member -MemberType NoteProperty -Name 'setNumber' -Value $setNumber
            }
            if ($PSBoundParameters.ContainsKey('orderBy')) {

                $jsonParams | Add-Member -MemberType NoteProperty -Name 'orderBy' -Value $orderBy
            }

            $stringParam = $jsonParams | ConvertTo-Json -Compress

            Write-Verbose "jsonParams are: $stringParam"

            # --- Make the REST Call
            $body = @{
                apiKey   = $Script:BricksetConnection.apiKey
                userHash = $null
                params   = $stringParam
            }

            Write-Verbose "Body is: $($body | ConvertTo-Json -Depth 5)"

            $response = Invoke-BricksetRestMethod -Method POST -URI '/getSets' -Body $body

            $response.sets
        }
        catch [Exception] {

            throw
        }
    }
}