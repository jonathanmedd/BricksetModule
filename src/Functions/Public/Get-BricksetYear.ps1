function Get-BricksetYear {
    <#
    .SYNOPSIS
    Get Brickset Years for a given Theme

    .DESCRIPTION
    Get Brickset Years for a given Theme

    .PARAMETER Theme
    Brickset Theme

    .INPUTS
    System.String.

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Get-BricksetYear

    .EXAMPLE
    Get-BricksetYear -Theme 'Indiana Jones'

    .EXAMPLE
    Get-BricksetTheme | Where-Object {$_.Theme -eq 'Indiana Jones'} | Get-BricksetYear
#>
    [CmdletBinding()][OutputType('System.Management.Automation.PSObject')]

    param
    (
        [parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$theme
    )

    begin {

        # --- Check for the presence of $Script:BricksetConnection
        xCheckGlobalBricksetConnection
    }

    process {

        try {

            # --- Make the REST Call
            $body = @{
                apiKey = $Script:BricksetConnection.apiKey
                Theme  = $theme
            }

            Write-Verbose "Body is: $($body | ConvertTo-Json -Depth 5)"

            $response = Invoke-BricksetRestMethod -Method POST -URI '/getYears' -Body $body

            $response.years
        }
        catch [Exception] {

            throw
        }
    }
}