function Get-BricksetCollectionUserNotes {
    <#
    .SYNOPSIS
    Get all a user's set notes.

    .DESCRIPTION
    Get all a user's set notes.

    .INPUTS
    None

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Get-BricksetCollectionUserNotes
#>
    [CmdletBinding()][OutputType('System.Management.Automation.PSObject')]

    param()

    try {

        # --- Check for the presence of $Script:BricksetConnection
        xCheckScriptBricksetConnection

        # --- Check for the UserHash
        xCheckUserHash

        # --- Make the REST Call
        $body = @{
            apiKey   = $Script:BricksetConnection.apiKey
            userHash = $Script:BricksetConnection.userHash
        }

        Write-Verbose "Body is: $($body | ConvertTo-Json -Depth 5)"

        $response = Invoke-BricksetRestMethod -Method POST -URI '/getUserNotes' -Body $body

        $response.userNotes
    }
    catch [Exception] {

        throw
    }
}