Describe 'First' {

    It 'getYears' {



        $Global:BricksetConnection = @{ }
        $Global:BricksetConnection.WebService = [PSCustomObject]@{} | Add-Member -Passthru ScriptMethod getYears { 

               [PSCustomObject]@{

                theme = "Star Wars"
                year = "1999"
                setCount = 13

                }

            }



        $theme = Get-BricksetYear -Theme 'Star Wars' | Select-Object -ExpandProperty theme
        $theme | Should Be 'Star'
    }
}