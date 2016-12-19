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
$Global:BricksetConnection.WebService | Add-Member -Passthru ScriptMethod getRecentlyUpdatedSets {

    [PSCustomObject]@{

        setID = "26495"
        number = "75170"
        numberVariant = 1
        name = "The Phantom"
        theme = "Star Wars"
    }
}
$Global:BricksetConnection.WebService | Add-Member -Passthru ScriptMethod getSets {

    [PSCustomObject]@{

        setID = "26495"
        number = "75170"
        numberVariant = 1
        name = "The Phantom"
        theme = "Star Wars"
    }
}
$Global:BricksetConnection.WebService | Add-Member -Passthru ScriptMethod getSet {

    [PSCustomObject]@{

        setID = "26495"
        number = "75170"
        numberVariant = 1
        name = "The Phantom"
        theme = "Star Wars"
    }
}
$Global:BricksetConnection.WebService | Add-Member -Passthru ScriptMethod getAdditionalImages {

    [PSCustomObject]@{

        thumbnailURL = "http://images.brickset.com/sets/AdditionalImages/7199-1/tn_7199-0000-xx-12-1_jpg.jpg"
        largeThumbnailURL = $null
        imageURL = "http://images.brickset.com/sets/AdditionalImages/7199-1/7199-0000-xx-12-1.jpg"
    }
}
$Global:BricksetConnection.WebService | Add-Member -Passthru ScriptMethod getInstructions {

    [PSCustomObject]@{

        URL = "http://cache.lego.com/bigdownloads/buildinginstructions/4561829.pdf"
        description = "BI 3006/64 - 7199 1/2"
    }
}
$Global:BricksetConnection.WebService | Add-Member -Passthru ScriptMethod getReviews {

    [PSCustomObject]@{

        author = "Z_wing"
        overallRating = 5
        title = "first to review!"
    }
}
$Global:BricksetConnection.WebService | Add-Member -Passthru ScriptMethod getSubthemes {

    [PSCustomObject]@{

        theme  = "Indiana Jones"
        subtheme = "Last Crusade"
        setCount = 3
        yearFrom = 2008
        yearTo = 2009
    }
}
$Global:BricksetConnection.WebService | Add-Member -Passthru ScriptMethod getThemes {

    [PSCustomObject]@{

        theme  = "Indiana Jones"
        setCount = 18
        subthemeCount = 4
        yearFrom = 2008
        yearTo = 2009
    }
}
$Global:BricksetConnection.WebService | Add-Member -Passthru ScriptMethod getYears {

    [PSCustomObject]@{

        theme = "Star Wars"
        year = "1999"
        setCount = 13
    }
}
$Global:BricksetConnection.WebService | Add-Member -Passthru ScriptMethod setMinifigCollection {

    "OK"
}
$Global:BricksetConnection.WebService | Add-Member -Passthru ScriptMethod setCollection {

    "OK"
}
$Global:BricksetConnection.WebService | Add-Member -Passthru ScriptMethod setCollection_wants {

    "OK"
}
$Global:BricksetConnection.WebService | Add-Member -Passthru ScriptMethod setCollection_userNotes {

    "OK"
}



# --- Get Tests
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
    It 'Testing Get-BricksetRecentlyUpdatedSet' {

        $name = Get-BricksetRecentlyUpdatedSet -DaysAgo 5 | Select-Object -ExpandProperty name
        $name | Should Be "The Phantom"
    }
    It 'Testing Get-BricksetSet' {

        $setID2 = Get-BricksetSet -SetNumber '26495-1' | Select-Object -ExpandProperty setId
        $setID2 | Should Be "26495"
    }
    It 'Testing Get-BricksetSetDetailed' {

        $setID3 = Get-BricksetSetDetailed -SetId '26495' | Select-Object -ExpandProperty setId
        $setID3 | Should Be "26495"
    }
    It 'Testing Get-BricksetSetAdditionalImage' {

        $imageURL = Get-BricksetSetAdditionalImage -SetId 6905 | Select-Object -ExpandProperty imageURL
        $imageURL | Should Be "http://images.brickset.com/sets/AdditionalImages/7199-1/7199-0000-xx-12-1.jpg"
    }
    It 'Testing Get-BricksetSetInstructions' {

        $URL = Get-BricksetSetInstructions -SetId 6905 | Select-Object -ExpandProperty URL
        $URL | Should Be "http://cache.lego.com/bigdownloads/buildinginstructions/4561829.pdf"
    }
    It 'Testing Get-BricksetSetOwned' {

        $name2 = Get-BricksetSetOwned | Select-Object -ExpandProperty name
        $name2 | Should Be "The Phantom"
    }
    It 'Testing Get-BricksetSetReview' {

        $title = Get-BricksetSetReview -SetId 6905 | Select-Object -ExpandProperty title
        $title | Should Be "first to review!"
    }
    It 'Testing Get-BricksetSetWanted' {

        $name3 = Get-BricksetSetWanted | Select-Object -ExpandProperty name
        $name3 | Should Be "The Phantom"
    }
    It 'Testing Get-BricksetSubtheme' {

        $subtheme = Get-BricksetSubtheme -Theme 'Indiana Jones' | Select-Object -ExpandProperty subtheme
        $subtheme | Should Be "Last Crusade"
    }
    It 'Testing Get-BricksetTheme' {

        $theme = Get-BricksetTheme | Select-Object -ExpandProperty theme
        $theme | Should Be "Indiana Jones"
    }
    It 'Testing Get-BricksetYear' {

        $theme = Get-BricksetYear -Theme 'Star Wars' | Select-Object -ExpandProperty theme
        $theme | Should Be 'Star Wars'
    }
}

# --- Set Tests
Describe 'Testing Set Functions' {

    It 'Testing Set-BricksetMinifgCollectionOwned' {

        $result = Set-BricksetMinifgCollectionOwned -MinifgNumber sw705 -QtyOwned 1 -Confirm:$false
        $result | Should Be "OK"
    }
    It 'Testing Set-BricksetMinifgCollectionWanted' {

        $result2 = Set-BricksetMinifgCollectionWanted -MinifgNumber sw705 -Confirm:$false
        $result2 | Should Be "OK"
    }
    It 'Testing Set-BricksetSetOwned' {

        $result3 = Set-BricksetSetOwned -SetId 26049 -QtyOwned 1 -Confirm:$false
        $result3 | Should Be "OK"
    }
    It 'Testing Set-BricksetSetUnwanted' {

        $result4 = Set-BricksetSetUnwanted -SetId 26049 -Confirm:$false
        $result4 | Should Be "OK"
    }
    It 'Testing Set-BricksetSetUserNotes' {

        $result5 = Set-BricksetSetUserNotes  -SetId 26049 -Notes "This is one of my favourites" -Confirm:$false
        $result5 | Should Be "OK"
    }
    It 'Testing Set-BricksetSetWanted' {

        $result6 = Set-BricksetSetUnwanted -SetId 26049 -Confirm:$false
        $result6 | Should Be "OK"
    }
}