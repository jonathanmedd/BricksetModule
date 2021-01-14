[![Build Status](https://dev.azure.com/jonmedd/BricksetModule/_apis/build/status/jonathanmedd.Bricksetmodule?branchName=master)](https://dev.azure.com/jonmedd/BricksetModule/_apis/build/status/jonathanmedd.Bricksetmodule?branchName=master) ![](https://img.shields.io/powershellgallery/v/Brickset) ![](https://img.shields.io/powershellgallery/dt/Brickset)

# PowerShell Brickset Module

The [www.brickset.com](http://www.brickset.com) website provides an [API](https://brickset.com/api/v3.asmx) for working with their data. This PowerShell module works with that [API](https://brickset.com/api/v3.asmx).

**Pre-Requisites**

PowerShell version 7.1 or later.

An API key from Brickset is required. Currently they are free and you can get one [here](https://brickset.com/tools/webservices/requestkey).
In order to use the inventory features of Brickset to track your own Lego collection a Brickset account is also required.

**Installation**

You can grab the latest version of the module from the PowerShell Gallery by running the following command:

```
Install-Module -Name Brickset
```

**Usage**

The below command will make all of the functions in the module available

```
Import-Module Brickset
```

To see a list of available functions:

```
Get-Command -Module Brickset
```

**Quick Start**

Use of non-inventory functions:

Supply your API key to create a connection variable

```
Connect-Brickset -APIKey 'Tk5C-KTA2-Gw2Q'
```

Use of all functions including inventory:

Supply your API key and also Brickset Website credentials to create a connection variable

```
$cred = Get-Credential
Connect-Brickset -APIKey 'Tk5C-KTA2-Gw2Q' -Credential $cred
```

Return all Indiana Jones themed Lego sets

```
Get-BricksetSet -Theme 'Indiana Jones'
```