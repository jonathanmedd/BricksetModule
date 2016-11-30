function Get-Brickset {
<#
    .SYNOPSIS
    Install Brickset
    
    .DESCRIPTION
    Install Brickset
    
    .PARAMETER Global
    Install for all users
    
    .PARAMETER ImportAfterInstall
    Import the module after a succesfull installation

    .PARAMETER InstallFromRepo
    Install latest release from github repo 

    .INPUTS
    None

    .OUTPUTS
    None

    .EXAMPLE
    Get-Brickset

    .EXAMPLE
    Get-Brickset -Global

    .EXAMPLE
    Get-Brickset -Global -ImportAfterInstall

#>
[CmdletBinding(SupportsShouldProcess,ConfirmImpact="High",DefaultParameterSetName="Standard")]

    Param (

    [parameter(Mandatory=$false,ParameterSetName="Standard")]
    [ValidateNotNullOrEmpty()]
    [String]$URI,

    [parameter(Mandatory=$false,ParameterSetName="Standard")]
    [ValidateNotNullOrEmpty()]
    [Switch]$Global,

    [parameter(Mandatory=$false,ParameterSetName="Standard")]
    [ValidateNotNullOrEmpty()]
    [Switch]$ImportAfterInstall

    )    

    begin {

     $Header = @"
  ____       _      _             _   
 |  _ \     (_)    | |           | |  
 | |_) |_ __ _  ___| | _____  ___| |_ 
 |  _ <| '__| |/ __| |/ / __|/ _ \ __|
 | |_) | |  | | (__|   <\__ \  __/ |_ 
 |____/|_|  |_|\___|_|\_\___/\___|\__|                                               
"@                                                                                                                

    Write-Output $Header
    Write-Output "Jonathan Medd $([char]0x00A9) 2016"           
    
    }
    
    process {

        try {

            # --- Set the installtion directory
            $InstallationDir = "C:\Users\$($env:USERNAME)\Documents\WindowsPowerShell\Modules\Brickset\"
    
            if ($PSBoundParameters.ContainsKey('Global')) {

                $InstallationDir = "C:\Program Files\WindowsPowerShell\Modules\Brickset\"
        
            }

            Write-Verbose -Message "Intallation directory is: $($InstallationDir)"

            # --- Download and unpack the latest release

            Write-Verbose -Message "Downloading latest release from $($URI)"

            $Response = Invoke-RestMethod -Method Get -Uri $URI

            $ZipUrl = $Response.zipball_url

            $GUID = ([guid]::NewGuid()).ToString()

            $OutputFile = "$($env:TEMP)\Brickset-$($GUID).zip"

            Invoke-RestMethod -Method Get -Uri $ZipUrl -OutFile $OutputFile

            Add-Type -assembly "system.io.compression.filesystem"

            $BricksetModulePath = $OutputFile.Substring(0, $OutputFile.LastIndexOf('.'))

            Write-Verbose -Message "Unpacking module to $($BricksetModulePath)"

            [io.compression.zipfile]::ExtractToDirectory($OutputFile, $BricksetModulePath)
          
            if ($PSCmdlet.ShouldProcess($InstallationDir)){

                # --- Remove module if it is present
                if ((Test-Path -Path $InstallationDir)){

                    Write-Verbose -Message "Removing old module"    

                    Remove-Item -Path $InstallationDir -Recurse -Force

                }

                # --- Install Brickset
                Write-Verbose -Message "Installing Brickset to $($InstallationDir)"

                Copy-Item -Path "$($BricksetModulePath)\*\Brickset" -Destination $InstallationDir -Force -Recurse

                if ($PSBoundParameters.ContainsKey('ImportAfterInstall')) {

                    Write-Verbose -Message "Attempting to remove old module from session"
                    Remove-Module -Name "Brickset" -Force -ErrorAction SilentlyContinue

                    Write-Verbose -Message "Importing module"
                    Import-Module -Name "Brickset" -Force

                }

                Write-Verbose -Message "Installation complete"

            }
        }
        catch [Exception]{

            throw
        }
    }
    end {

        Write-Verbose -Message "Removing temporary file $($OutputFile)"
        Remove-item -Path $OutputFile -Recurse -Force -ErrorAction SilentlyContinue -Confirm:$false

        Write-Verbose -Message "Removing temporary directory $($BricksetModulePath)"
        Remove-Item -Path $BricksetModulePath -Recurse -Force -ErrorAction SilentlyContinue -Confirm:$false

        }            
 
}

# --- Install Brickset for the current user
Get-Brickset -URI "https://api.github.com/repos/jonathanmedd/BricksetModule/releases/latest" -ImportAfterInstall -Verbose
