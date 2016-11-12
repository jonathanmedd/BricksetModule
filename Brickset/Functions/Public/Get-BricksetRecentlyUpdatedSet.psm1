function Get-BricksetRecentlyUpdatedSet {
<#
    .SYNOPSIS
    Get Brickset Sets that have recently changed
    
    .DESCRIPTION
    Get Brickset Sets that have recently changed
    
    .PARAMETER APIKey
    API Key

    .PARAMETER HoursAgo
    Number of hours to search back for

    .PARAMETER DaysAgo
    Number of days to search back for

    .PARAMETER WeeksAgo
    Number of weeks to search back for

    .PARAMETER MonthsAgo
    Number of months to search back for

    .INPUTS
    System.String.
    System.Int

    .OUTPUTS
    Brickset.sets

    .EXAMPLE
    Get-BricksetRecentlyUpdatedSet -APIKey 'Tk5C-KTA2-Gw2Q' -DaysAgo 5
#>
[CmdletBinding(DefaultParameterSetName='HoursAgo')][OutputType('Brickset.sets')]

    Param
    (

    [parameter(Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [String]$APIKey,

    [parameter(Mandatory=$true,ParameterSetName='HoursAgo')]
    [ValidateNotNullOrEmpty()]
    [Int]$HoursAgo,

    [parameter(Mandatory=$true,ParameterSetName='DaysAgo')]
    [ValidateNotNullOrEmpty()]
    [Int]$DaysAgo,

    [parameter(Mandatory=$true,ParameterSetName='WeeksAgo')]
    [ValidateNotNullOrEmpty()]
    [Int]$WeeksAgo,

    [parameter(Mandatory=$true,ParameterSetName='MonthsAgo')]
    [ValidateNotNullOrEmpty()]
    [Int]$MonthsAgo
    )    

try {

    # --- If $APIKey not supplied, try $Global:BricksetAPIKey

    if (!($PSBoundParameters.ContainsKey('APIKey'))){
            
        try {
    
            Get-Variable BricksetAPIKey | Out-Null
            $APIKey = $BricksetAPIKey
        }
        catch [Exception] {

            throw 'Brickset API Key not specified nor exists in $Global:BricksetAPIKey. Please set this to continue'
        }
    }


    # --- Determine time to look back for
    switch ($PsCmdlet.ParameterSetName) 
    { 
        "HoursAgo"  { $MinutesAgo = $HoursAgo * 60; break} 
        "DaysAgo"  { $MinutesAgo = $DaysAgo * 60 * 24; break}
        "WeeksAgo"  { $MinutesAgo = $WeeksAgo * 60 * 24 * 7; break} 
        "MonthsAgo"  { $MinutesAgo = ((Get-Date) - ((Get-Date).AddMonths($MonthsAgo * -1))).TotalMinutes; break}  
    }

    # --- Make the Webservice Call
    if (!($Webservice)){

        $Global:Webservice = New-WebServiceProxy -Uri 'http://brickset.com/api/v2.asmx?WSDL' -Namespace 'Brickset' -Class 'Sets'
    }

    $Webservice.getRecentlyUpdatedSets($APIKey,$MinutesAgo)
}
catch [Exception]{
        
    throw "Unable to get Brickset Recently Updated Sets"
}
}