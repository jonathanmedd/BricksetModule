function Get-BricksetSetInstructions {
    <#
    .SYNOPSIS
    Get Brickset Set Instructions

    .DESCRIPTION
    Get Brickset Set Instructions

    .PARAMETER setId
    Brickset SetId (not the Lego Set Number)

    .INPUTS
    System.String.

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Get-BricksetSetInstructions -SetId 6905

    .EXAMPLE
    Get-BricksetSet -Theme 'Indiana Jones' | Get-BricksetSetInstructions

    .EXAMPLE
    Get-BricksetSet -SetNumber 75055-1 | Get-BricksetSetInstructions | Select-Object -First 1 -ExpandProperty url | Foreach-Object {Invoke-Expression 'cmd.exe /C start $_'}

    .EXAMPLE
    Get-BricksetSet -Theme 'Indiana Jones' | Get-BricksetSetInstructions | Select-Object -ExpandProperty url | ForEach-Object {$file = ($_.split('/'))[-1]; Start-BitsTransfer -Source $_ -Destination "C:\Users\jmedd\Documents\$file"}
#>
    [CmdletBinding()][OutputType('System.Management.Automation.PSObject')]

    Param
    (
        [parameter(Mandatory = $false, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$setId
    )

    begin {

        # --- Check for the presence of $Global:BricksetConnection
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

            $response = Invoke-BricksetRestMethod -Method POST -URI '/getInstructions' -Body $body

            $response.instructions
        }
        catch [Exception] {

            throw
        }
    }
}