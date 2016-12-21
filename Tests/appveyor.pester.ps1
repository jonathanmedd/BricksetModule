# This script will invoke pester tests
# It should invoke on PowerShell v2 and later
# We serialize XML results and pull them in appveyor.yml

#If Finalize is specified, we collect XML output, upload tests, and indicate build errors
param(
    [switch]$Finalize,
    [switch]$Test,
    [string]$ProjectRoot = $ENV:APPVEYOR_BUILD_FOLDER
)

#Initialize some variables, move to the project root
$Timestamp = Get-date -uformat "%Y%m%d-%H%M%S"
$PSVersion = $PSVersionTable.PSVersion.Major
$TestFile = "TestResults_PS$PSVersion`_$TimeStamp.xml"

$Address = "https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)"
Set-Location $ProjectRoot

$Verbose = @{}
if($env:APPVEYOR_REPO_BRANCH -and $env:APPVEYOR_REPO_BRANCH -notlike "master")
{
    $Verbose.add("Verbose",$True)
}

#Run a test with the current version of PowerShell, upload results
if($Test)
{
    "`n`tSTATUS: Testing with PowerShell $PSVersion`n"

    Import-Module Pester

    Invoke-Pester @Verbose -Path "$ProjectRoot\Tests" -OutputFormat NUnitXml -OutputFile "$ProjectRoot\$TestFile"

    If($env:APPVEYOR_JOB_ID)
    {
        (New-Object 'System.Net.WebClient').UploadFile( $Address, "$ProjectRoot\$TestFile" )
    }
}

#If finalize is specified, display errors and fail build if we ran into any
If($Finalize)
{
    #Show status...
        $ResultFiles = Get-ChildItem -Path $ProjectRoot\TestResults*.xml
        "`n`tSTATUS: Finalizing results`n"
        "COLLATING FILES:`n$($ResultFiles | Select-Object -ExpandProperty FullName | Out-String)"

    #What failed?
        foreach ($ResultFile in $ResultFiles){

            [xml]$XML = Get-Content $ResultFile
            $FailedCount = $XMl.'test-results'.failures

            if ($FailedCount -gt 0) {

                $FailedItems = $XMl.'test-results'.'test-suite'.results.'test-suite'.results.'test-case' | Where-Object {$_.success -eq 'False'}

                "FAILED TESTS SUMMARY:`n"
                $FailedItems | ForEach-Object {
                    $Item = $_
                    [pscustomobject]@{
                        Name = $Item.Name
                        Description = $Item.Description
                        Result = $Item.Result
                    }
                } |
                    Sort-Object Name, Descripton Result | Format-List

                throw "$FailedCount tests failed."
            }
        }
}