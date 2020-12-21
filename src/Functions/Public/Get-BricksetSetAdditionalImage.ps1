function Get-BricksetSetAdditionalImage {
<#
    .SYNOPSIS
    Get Brickset Set Additional Images
    
    .DESCRIPTION
    Get Brickset Set Additional Images

    .PARAMETER SetId
    Brickset SetId (not the Lego Set Number)

    .INPUTS
    System.String.

    .OUTPUTS
    Brickset.additionalImages

    .EXAMPLE
    Get-BricksetSetAdditionalImage -SetId 6905

    .EXAMPLE
    Get-BricksetSet -Theme 'Indiana Jones' | Get-BricksetSetAdditionalImage

    .EXAMPLE
    Get-BricksetSetAdditionalImage -SetId 6905 | Select-Object -ExpandProperty imageurl | Foreach-Object {Invoke-Expression “cmd.exe /C start $_”}
#>
[CmdletBinding()][OutputType('Brickset.additionalImages')]

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
        
            $BricksetConnection.WebService.getAdditionalImages($BricksetConnection.APIKey,$SetId)
        }
        catch [Exception]{
            
            throw
        }
    }
    end {

    }
}