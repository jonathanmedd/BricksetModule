function Invoke-BricksetRestMethod {
<#
    .SYNOPSIS
    Wrapper for Invoke-RestMethod/Invoke-WebRequest with Brickset specifics

    .DESCRIPTION
    Wrapper for Invoke-RestMethod/Invoke-WebRequest with Brickset specifics

    .PARAMETER Method
    REST Method:
    Supported Methods: GET, POST, PUT,DELETE

    .PARAMETER URI
    API URI, e.g. /getThemes

    .PARAMETER Headers
    Optionally supply custom headers

    .PARAMETER Body
    REST Body in JSON format

    .PARAMETER OutFile
    Save the results to a file

    .PARAMETER WebRequest
    Use Invoke-WebRequest rather than the default Invoke-RestMethod

    .INPUTS
    System.String
    Switch

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    $body = @{
        apiKey ='4-r6wS-3JSq-xIpLe'
    }

    Invoke-BricksetRestMethod -Method POST -URI '/getThemes' -Body $body
#>
[CmdletBinding(DefaultParameterSetName="Standard")][OutputType('System.Management.Automation.PSObject')]

    Param (

        [Parameter(Mandatory=$true, ParameterSetName="Standard")]
        [Parameter(Mandatory=$true, ParameterSetName="Body")]
        [Parameter(Mandatory=$true, ParameterSetName="OutFile")]
        [ValidateSet("GET","POST","PUT","DELETE")]
        [String]$method,

        [Parameter(Mandatory=$true, ParameterSetName="Standard")]
        [Parameter(Mandatory=$true, ParameterSetName="Body")]
        [Parameter(Mandatory=$true, ParameterSetName="OutFile")]
        [ValidateNotNullOrEmpty()]
        [String]$uri,

        [Parameter(Mandatory=$false, ParameterSetName="Standard")]
        [Parameter(Mandatory=$false, ParameterSetName="Body")]
        [Parameter(Mandatory=$false, ParameterSetName="OutFile")]
        [ValidateNotNullOrEmpty()]
        [System.Collections.IDictionary]$headers,

        [Parameter(Mandatory=$false, ParameterSetName="Body")]
        [ValidateNotNullOrEmpty()]
        [Hashtable]$body,

        [Parameter(Mandatory=$false, ParameterSetName="OutFile")]
        [ValidateNotNullOrEmpty()]
        [String]$outFile,

        [Parameter(Mandatory=$false, ParameterSetName="Standard")]
        [Parameter(Mandatory=$false, ParameterSetName="Body")]
        [Parameter(Mandatory=$false, ParameterSetName="OutFile")]
        [Switch]$webRequest
    )

    # --- Test for existing connection to vRA
    if (-not $Script:BricksetConnection){

        throw "Brickset Connection variable does not exist. Please run Connect-Brickset first to create it"
    }

    # --- Create Invoke-RestMethod Parameters
    $fullURI = "$($Script:BricksetConnection.url)$($uri)"


    # --- Set up default parmaeters
    $params = @{

        method = $method
        contentType = 'application/x-www-form-urlencoded'
        uri = $fullURI
    }

    # --- Add default headers if not passed
    if ($PSBoundParameters.ContainsKey("headers")){

        $params.Add('headers', $headers)
    }

    if ($PSBoundParameters.ContainsKey("body")){

        $params.Add("body", $body)

        # --- Log the payload being sent to the server
        Write-Debug -Message ($body | ConvertTo-Json -Depth 5)
    }

    if ($PSBoundParameters.ContainsKey("outfile")){

        $params.Add("outFile", $outFile)

    }

    try {

        # --- Use either Invoke-WebRequest or Invoke-RestMethod
        if ($WebRequest.IsPresent) {

            Invoke-WebRequest @params
        }
        else {

            Invoke-RestMethod @params
        }
    }
    catch {

        throw $_
    }
}