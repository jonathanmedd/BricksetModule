function Get-BricksetMinifigCollectionWanted {
    <#
    .SYNOPSIS
    Get Brickset Minifg Collection Wanted

    .DESCRIPTION
    Get Brickset Minifg Collection Wanted

    .INPUTS
    None

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Get-BricksetMinifigCollectionWanted
#>
    [CmdletBinding()][OutputType('System.Management.Automation.PSObject')]

    param ()

    try {

        # --- Check for the presence of $Script:BricksetConnection
        xCheckGlobalBricksetConnection

        # --- Check for the UserHash
        xCheckUserHash

        # - Prepare the JSON params
        $jsonParams = [PSCustomObject] @{

            wanted    = '1'
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

        $response = Invoke-BricksetRestMethod -Method POST -URI '/getMinifigCollection' -Body $body

        $response.minifigs
    }
    catch [Exception] {

        throw
    }
}