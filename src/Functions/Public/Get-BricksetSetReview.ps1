function Get-BricksetSetReview {
    <#
    .SYNOPSIS
    Get Brickset Set Reviews

    .DESCRIPTION
    Get Brickset Set Reviews

    .PARAMETER SetId
    Brickset SetId (not the Lego Set Number)

    .INPUTS
    System.String.

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Get-BricksetSetReview -SetId 6905

    .EXAMPLE
    Get-BricksetSet -Theme 'Indiana Jones' | Get-BricksetSetReview
#>
    [CmdletBinding()][OutputType('System.Management.Automation.PSObject')]

    Param
    (
        [parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$setId
    )

    begin {

        # --- Check for the presence of $Script:BricksetConnection
        xCheckScriptBricksetConnection
    }
    process {

        try {

            # --- Make the REST Call
            $body = @{
                apiKey = $Script:BricksetConnection.apiKey
                setId  = $setId
            }

            Write-Verbose "Body is: $($body | ConvertTo-Json -Depth 5)"

            $response = Invoke-BricksetRestMethod -Method POST -URI '/getReviews' -Body $body

            $response.reviews
        }
        catch [Exception] {

            throw
        }
    }
}