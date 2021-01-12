function Get-BricksetMinifigCollectionOwned {
    <#
    .SYNOPSIS
    Get Brickset Minifg Collection Owned

    .DESCRIPTION
    Get Brickset Minifg Collection Owned

    .INPUTS
    None

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Get-BricksetMinifigCollectionOwned
#>
    [CmdletBinding()][OutputType('System.Management.Automation.PSObject')]

    param ()

    try {

        # --- Check for the presence of $Script:BricksetConnection
        xCheckScriptBricksetConnection

        # --- Check for the UserHash
        xCheckUserHash

        # - Prepare the JSON params
        $jsonParams = [PSCustomObject] @{

            owned    = '1'
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