function Get-BricksetSetOwned {
    <#
    .SYNOPSIS
    Get Brickset Sets Owned

    .DESCRIPTION
    Get Brickset Sets Owned

    .PARAMETER orderBy
    Specify Sort Order

    .PARAMETER pageSize
    Specify how many records to return

    .INPUTS
    System.String.
    System.Int.

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Get-BricksetSetOwned -OrderBy Pieces
#>
    [CmdletBinding()][OutputType('System.Management.Automation.PSObject')]

    Param
    (
        [parameter(Mandatory = $false)]
        [ValidateSet('Number', 'YearFrom', 'Pieces', 'Minifigs', 'Rating', 'UKRetailPrice', 'USRetailPrice', 'CARetailPrice', 'DERetailPrice', 'FRRetailPrice',
            'UKPricePerPiece', 'USPricePerPiece', 'CAPricePerPiece', 'DEPricePerPiece', 'FRPricePerPiece', 'Theme', 'Subtheme', 'Name', 'Random', 'QtyOwned', 'OwnCount', 'WantCount', 'UserRating', 'CollectionID')]
        [String]$orderBy,

        [parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Int]$pageSize = 500
    )

    try {

        # --- Check for the presence of $Script:BricksetConnection
        xCheckGlobalBricksetConnection

        # --- Check for the UserHash
        xCheckUserHash

        # - Prepare the JSON params
        $jsonParams = [PSCustomObject] @{

            owned    = '1'
            pageSize = $pageSize
        }

        if ($PSBoundParameters.ContainsKey('orderBy')) {

            $jsonParams | Add-Member -MemberType NoteProperty -Name 'orderBy' -Value $orderBy
        }

        $stringParam = $jsonParams | ConvertTo-Json -Compress

        Write-Verbose "jsonParams are: $stringParam"

        # --- Make the REST Call
        $body = @{
            apiKey   = $Script:BricksetConnection.apiKey
            userHash = $Script:BricksetConnection.userHash
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