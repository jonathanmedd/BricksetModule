function Get-BricksetSetAdditionalImage {
    <#
    .SYNOPSIS
    Get Brickset Set Additional Images

    .DESCRIPTION
    Get Brickset Set Additional Images

    .PARAMETER setId
    Brickset SetId (not the Lego Set Number)

    .INPUTS
    System.String.

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Get-BricksetSetAdditionalImage -SetId 6905

    .EXAMPLE
    Get-BricksetSet -Theme 'Indiana Jones' | Get-BricksetSetAdditionalImage

    .EXAMPLE
    Get-BricksetSetAdditionalImage -SetId 6905 | Select-Object -ExpandProperty imageurl | Foreach-Object {Invoke-Expression 'cmd.exe /C start $_'}
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
        xCheckGlobalBricksetConnection
    }
    process {

        try {

            # --- Make the REST Call
            $body = @{
                apiKey = $Script:BricksetConnection.apiKey
                setId  = $setId
            }

            Write-Verbose "Body is: $($body | ConvertTo-Json -Depth 5)"

            $response = Invoke-BricksetRestMethod -Method POST -URI '/getAdditionalImages' -Body $body

            $response.additionalImages
        }
        catch [Exception] {

            throw
        }
    }
    end {

    }
}