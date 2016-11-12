function Get-BricksetRecentlyUpdatedSet {
<#
    .SYNOPSIS
    Get Brickset Sets that have recently changed
    
    .DESCRIPTION
    Get Brickset Sets that have recently changed

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
    Get-BricksetRecentlyUpdatedSet -DaysAgo 5
#>
[CmdletBinding(DefaultParameterSetName='HoursAgo')][OutputType('Brickset.sets')]

    Param
    (

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

        # --- Check for the presence of $Global:BricksetConnection
        xCheckGlobalBricksetConnection

        # --- Determine time to look back for
        switch ($PsCmdlet.ParameterSetName) 
        { 
            "HoursAgo"  { $MinutesAgo = $HoursAgo * 60; break} 
            "DaysAgo"  { $MinutesAgo = $DaysAgo * 60 * 24; break}
            "WeeksAgo"  { $MinutesAgo = $WeeksAgo * 60 * 24 * 7; break} 
            "MonthsAgo"  { $MinutesAgo = ((Get-Date) - ((Get-Date).AddMonths($MonthsAgo * -1))).TotalMinutes; break}  
        }

        # --- Make the Webservice Call
        $BricksetConnection.WebService.getRecentlyUpdatedSets($BricksetConnection.APIKey,$MinutesAgo)
    }
    catch [Exception]{
            
        throw
    }
}