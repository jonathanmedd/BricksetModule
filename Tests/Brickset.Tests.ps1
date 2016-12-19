# --- Build out Brickset Connection for tests
$Global:BricksetConnection = @{ }
$Global:BricksetConnection.UserHash = 'sdfjhg23'
$Global:BricksetConnection.WebService = [PSCustomObject]@{} | Add-Member -Passthru ScriptMethod getCollectionTotals {

    [PSCustomObject]@{

        totalSetsOwned = 3
        totalDistinctSetsOwned = 3
        totalSetsWanted = 13
        totalMinifigsOwned = 5
        totalMinifigsWanted = 0
    }
}
$Global:BricksetConnection.WebService | Add-Member -Passthru ScriptMethod getUserNotes {

    [PSCustomObject]@{

        setID = "26049"
        userNotes1 = "testing"
    }
}
$Global:BricksetConnection.WebService | Add-Member -Passthru ScriptMethod getMinifigCollection {

    [PSCustomObject]@{

        minifigNumber = "sw714"
        ownedInSets = 0
        ownedLoose = 0
        ownedTotal = 0
        wanted = "True"
    }
}
$Global:BricksetConnection.WebService | Add-Member -Passthru ScriptMethod getYears {

    [PSCustomObject]@{

        theme = "Star Wars"
        year = "1999"
        setCount = 13
    }
}




# --- Tests
Describe 'Testing Get Functions' {

    It 'Testing Get-BricksetCollectionTotals' {

        $totalSetsOwned = Get-BricksetCollectionTotals | Select-Object -ExpandProperty totalSetsOwned
        $totalSetsOwned | Should Be 3
    }
    It 'Testing Get-BricksetCollectionUserNotes' {

        $setID = Get-BricksetCollectionUserNotes | Select-Object -ExpandProperty setID
        $setID | Should Be "26049"
    }
    It 'Testing Get-BricksetMinifigCollectionOwned' {

        $minifigNumber = Get-BricksetMinifigCollectionOwned | Select-Object -ExpandProperty minifigNumber
        $minifigNumber | Should Be "sw714"
    }
    It 'Testing Get-BricksetMinifigCollectionWanted' {

        $wanted = Get-BricksetMinifigCollectionWanted | Select-Object -ExpandProperty wanted
        $wanted | Should Be "True"
    }
    It 'Testing Get-BricksetYear' {

        $theme = Get-BricksetYear -Theme 'Star Wars' | Select-Object -ExpandProperty theme
        $theme | Should Be 'Star Wars'
    }
}