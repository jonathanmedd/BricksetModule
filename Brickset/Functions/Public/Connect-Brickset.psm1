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
    [String]$APIKey,

    [Parameter(Mandatory=$false)]
	[ValidateNotNullOrEmpty()]
	[Management.Automation.PSCredential]$Credential
    )    

    try {

        # --- Create Output Object                
        $Global:BricksetConnection = [pscustomobject]@{                        
                        
            APIKey = $APIKey
            UserHash = $null
            WebService = New-WebServiceProxy -Uri 'http://brickset.com/api/v2.asmx?WSDL' -Namespace 'Brickset' -Class 'Sets'
        }

        # --- Update BricksetConnection with UserHash
        if ($PSBoundParameters.ContainsKey("Credential")){

            $Username = $Credential.UserName
            $Password = $Credential.GetNetworkCredential().Password
            $UserHash = $Global:BricksetConnection.WebService.login($Global:BricksetConnection.APIKey, $Username, $Password)
            $Global:BricksetConnection.UserHash = $UserHash
        }
    }
    catch [Exception]{
            
        throw
    }
    finally {

        Write-Output $BricksetConnection 
    }
}