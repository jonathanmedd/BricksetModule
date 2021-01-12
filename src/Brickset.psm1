# Expose each Public and Private function as part of the module
foreach ($privateScript in Join-Path $PSScriptRoot Functions\Private\*.ps1 -Resolve) {
    . $privateScript
}
foreach ($publicFunction in Join-Path $PSScriptRoot Functions\Public\*.ps1 -Resolve) {
    . $publicFunction
    Export-ModuleMember -Function ([System.IO.Path]::GetFileNameWithoutExtension($publicFunction))
}