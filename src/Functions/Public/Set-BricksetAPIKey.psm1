function Set-BricksetAPIKey {
<#
    .SYNOPSIS
    Set the Brickset API Key as a Global Variable
    
    .DESCRIPTION
    Set the Brickset API Key as a Global Variable
    
    .PARAMETER APIKey
    API Key

    .INPUTS
    System.String.

    .OUTPUTS
    System.Management.Automation.PSVariable

    .EXAMPLE
    Set-BricksetAPIKey -APIKey 'Tk5C-KTA2-Gw2Q'
#>
[CmdletBinding(SupportsShouldProcess,ConfirmImpact="High")][OutputType('System.Management.Automation.PSVariable')]

    Param
    (

    [parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$APIKey
    )    

try {

if ($PSCmdlet.ShouldProcess($APIKey)){
            
    $Global:BricksetAPIKey = $APIKey
    Get-Variable BricksetAPIKey
}

}
catch [Exception]{
        
    throw "Unable to set Brickset API Key"
}
}