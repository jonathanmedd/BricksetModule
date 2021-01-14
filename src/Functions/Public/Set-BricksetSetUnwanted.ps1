function Set-BricksetSetUnwanted {
    <#
    .SYNOPSIS
    Set a Brickset Set to Unwanted status

    .DESCRIPTION
    Set a Brickset Set to Unwanted status

    .PARAMETER SetId
    Brickset SetId

    .INPUTS
    String

    .OUTPUTS
    None

    .EXAMPLE
    Set-BricksetSetUnwanted -SetId 26049
#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]

    param
    (
        [parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$setId
    )

    begin {

        # --- Check for the presence of $Script:BricksetConnection
        xCheckScriptBricksetConnection

        # --- Check for the UserHash
        xCheckUserHash
    }

    process {

        try {

            if ($PSCmdlet.ShouldProcess($SetId)) {

                # - Prepare the JSON params
                $jsonParams = [PSCustomObject] @{

                    want = '0'
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
}