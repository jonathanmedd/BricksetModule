function Get-BricksetSubtheme {
    <#
    .SYNOPSIS
    Get Brickset Subthemes for a given Theme

    .DESCRIPTION
    Get Brickset Subthemes for a given Theme

    .PARAMETER Theme
    Brickset Theme

    .INPUTS
    System.String.

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Get-BricksetSubtheme -Theme 'Indiana Jones'

    .EXAMPLE
    Get-BricksetTheme | Where-Object {$_.Theme -eq 'Indiana Jones'} | Get-BricksetSubtheme
#>
    [CmdletBinding()][OutputType('System.Management.Automation.PSObject')]

    param
    (
        [parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$theme
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
                Theme  = $theme
            }

            Write-Verbose "Body is: $($body | ConvertTo-Json -Depth 5)"

            $response = Invoke-BricksetRestMethod -Method POST -URI '/getSubthemes' -Body $body

            $response.subthemes
        }
        catch [Exception] {

            throw
        }
    }
}