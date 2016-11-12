function Get-BricksetSetInstructions {
<#
    .SYNOPSIS
    Get Brickset Set Instructions
    
    .DESCRIPTION
    Get Brickset Set Instructions
    
    .PARAMETER SetId
    Brickset SetId (not the Lego Set Number)

    .INPUTS
    System.String.

    .OUTPUTS
    Brickset.instructions

    .EXAMPLE
    Get-BricksetSetInstructions -SetId 6905

    .EXAMPLE
    Get-BricksetSet -Theme 'Indiana Jones' | Get-BricksetSetInstructions

    .EXAMPLE
    Get-BricksetSet -SetNumber 75055-1 | Get-BricksetSetInstructions | Select-Object -First 1 -ExpandProperty url | Foreach-Object {Invoke-Expression “cmd.exe /C start $_”}

    .EXAMPLE
    Get-BricksetSet -Theme 'Indiana Jones' | Get-BricksetSetInstructions | Select-Object -ExpandProperty url | ForEach-Object {$file = ($_.split('/'))[-1]; Start-BitsTransfer -Source $_ -Destination "C:\Users\jmedd\Documents\$file"}
#>
[CmdletBinding()][OutputType('Brickset.instructions')]

    Param
    (

    [parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [String]$SetId
    )

    begin {

        # --- Check for the presence of $Global:BricksetConnection
        xCheckGlobalBricksetConnection
    }
    process {
        
        try {
        
            $BricksetConnection.WebService.getInstructions($BricksetConnection.APIKey,$SetId)
        }
        catch [Exception]{
            
            throw
        }
    }
}