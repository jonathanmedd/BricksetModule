function Connect-Brickset {
<#
    .SYNOPSIS
    Make a connection to the Brickset API

    .DESCRIPTION
    Make a connection to the Brickset API. Set the Brickset API Key and UserHash

    .PARAMETER APIKey
    API Key

    .PARAMETER Credential
    Supply Brickset Credentials

    .INPUTS
    System.String
    Management.Automation.PSCredential

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Connect-Brickset -APIKey 'Tk5C-KTA2-Gw2Q'

    .EXAMPLE
    $cred = Get-Credential
    Connect-Brickset -APIKey 'Tk5C-KTA2-Gw2Q' -Credential $cred
#>
[CmdletBinding()][OutputType('System.Management.Automation.PSObject')]

    Param
    (

    [parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$apiKey,

    [Parameter(Mandatory=$false)]
	[ValidateNotNullOrEmpty()]
	[Management.Automation.PSCredential]$credential
    )

    try {

        # --- Create Output Object
        $Script:bricksetConnection = [pscustomobject]@{

            apiKey = $apiKey
            userHash = $null
            url = 'https://brickset.com/api/v3.asmx/'
        }

        # --- Update BricksetConnection with UserHash
        if ($PSBoundParameters.ContainsKey("credential")){

            $username = $credential.UserName
            $password = $credential.GetNetworkCredential().Password

            $contentType = 'application/x-www-form-urlencoded'

            $body = @{
                apiKey = $Script:bricksetConnection.apiKey
                username = $username
                password = $password
            }

            $response = Invoke-RestMethod -Method POST -Uri 'https://brickset.com/api/v3.asmx/login' -ContentType $contentType -body $body

            $Script:bricksetConnection.userHash = $response.hash
        }

    }
    catch [Exception]{

        throw
    }
    finally {

        Write-Output $bricksetConnection
    }
}