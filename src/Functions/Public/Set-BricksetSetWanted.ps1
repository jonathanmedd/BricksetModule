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
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]

    param
    (
        [parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$setId
    )

    try {

        # --- Check for the presence of $Script:BricksetConnection
        xCheckScriptBricksetConnection

        # --- Check for the UserHash
        xCheckUserHash

        if ($PSCmdlet.ShouldProcess($setId)) {

            # - Prepare the JSON params
            $jsonParams = [PSCustomObject] @{

                want = '1'
            }

            $stringParam = $jsonParams | ConvertTo-Json -Compress

            Write-Verbose "jsonParams are: $stringParam"

            # --- Make the REST Call
            $body = @{
                apiKey   = $Script:BricksetConnection.apiKey
                userHash = $Script:BricksetConnection.userHash
                params   = $stringParam
                setID    = $setId
            }

            Write-Verbose "Body is: $($body | ConvertTo-Json -Depth 5)"

            Invoke-BricksetRestMethod -Method POST -URI '/setCollection' -Body $body
        }
    }
    catch [Exception] {

        throw
    }
}