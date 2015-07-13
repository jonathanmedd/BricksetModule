# PowerShell Brickset Module

The [www.brickset.com](http://www.brickset.com) website provides an [API](http://brickset.com/tools/webservices/v2) for working with their data. This PowerShell module works with that [API](http://brickset.com/tools/webservices/v2).

**Pre-Requisites**

PowerShell version 4 or later.

An API key from Brickset is required. Currently they are free and you can get one [here](http://brickset.com/tools/webservices/requestkey).


**Installation**


1) Download all files comprising the module. **Ensure the files are unblocked**.

2) Copy the module folder to your module folder path, e.g. C:\Users\username\Documents\WindowsPowerShell\Modules\


**Usage**

The below command will make all of the functions in the module available

Import-Module Brickset

To see a list of available functions:

Get-Command -Module Brickset

- Get-BricksetRecentlyUpdatedSet
- Get-BricksetSet
- Get-BricksetSetAdditionalImage
- Get-BricksetSetDetailed
- Get-BricksetSetInstructions
- Get-BricksetSetReview
- Get-BricksetSubtheme
- Get-BricksetTheme
- Get-BricksetYear
- Set-BricksetAPIKey
- Test-BricksetAPIKey

                         



**Nested Modules**

You will note that each function is itself a nested module of the PowerCLITools module. In this [blog post](www.jonathanmedd.net/2013/11/powercli-in-the-enterprise-breaking-the-magicians-code-function-templates.html) I describe why I make my modules like this.


