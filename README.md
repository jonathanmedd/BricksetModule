# PowerShell Brickset Module

The [www.brickset.com](http://www.brickset.com) website provides an [API](http://brickset.com/tools/webservices/v2) for working with their data. This PowerShell module works with that [API](http://brickset.com/tools/webservices/v2).

**Pre-Requisites**

PowerShell version 4 or later.

An API key from Brickset is required. Currently they are free and you can get one [here](http://brickset.com/tools/webservices/requestkey).


**Installation**


PowerShell v5 users: You grab the latest version of the module from the PowerShell Gallery by running the following command:

```
Install-Module -Name Brickset
```

PowerShell v4 users: Try this handy one liner to download and install the module:

```
(new-object Net.WebClient).DownloadString("https://github.com/jonathanmedd/BricksetModule/blob/master/Get-Brickset.ps1") | iex
```

**Usage**

The below command will make all of the functions in the module available

Import-Module Brickset

To see a list of available functions:

Get-Command -Module Brickset

Connect-Brickset
Get-BricksetCollectionTotals
Get-BricksetCollectionUserNotes
Get-BricksetMinifigCollectionOwned
Get-BricksetMinifigCollectionWanted
Get-BricksetRecentlyUpdatedSet
Get-BricksetSet
Get-BricksetSetAdditionalImage
Get-BricksetSetDetailed
Get-BricksetSetInstructions
Get-BricksetSetOwned
Get-BricksetSetReview
Get-BricksetSetWanted
Get-BricksetSubtheme
Get-BricksetTheme
Get-BricksetYear
Set-BricksetMinifgCollectionOwned
Set-BricksetMinifgCollectionWanted
Set-BricksetSetOwned
Set-BricksetSetUnwanted
Set-BricksetSetUserNotes
Set-BricksetSetWanted
Test-BricksetAPIKey
