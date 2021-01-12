function Set-BricksetSetOwned {
    <#
    .SYNOPSIS
    Set a Brickset Set to Owned status

    .DESCRIPTION
    Set a Brickset Set to Owned status. Include the number of sets owned.

    .PARAMETER SetId
    Brickset SetId

    .PARAMETER QtyOwned
    Quantity Owned

    .PARAMETER Rating
    Supply a rating from 1 - 5

    .PARAMETER UserNotes
    Supply User Notes

    .INPUTS
    System.String
    System.Number

    .OUTPUTS
    None

    .EXAMPLE
    Set-BricksetSetOwned -SetId 26049 -QtyOwned 1 -Rating 5 -UserNotes 'One of my favourite sets'

    .EXAMPLE
    Get-BricksetSet -SetNumber '7199-1' | Set-BricksetSetOwned -QtyOwned 1 -Confirm:$false
#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]

    param
    (
        [parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$setId,

        [parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [Int]$qtyOwned,

        [parameter(Mandatory = $false)]
        [ValidateSet(1, 2, 3, 4, 5)]
        [Int]$rating,

        [parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$userNotes
    )

    try {

        # --- Check for the presence of $Script:BricksetConnection
        xCheckGlobalBricksetConnection

        # --- Check for the UserHash
        xCheckUserHash

        if ($PSCmdlet.ShouldProcess($setId)) {

            # - Prepare the JSON params
            $jsonParams = [PSCustomObject] @{

                own      = '1'
                qtyOwned = $qtyOwned
            }

            if ($PSBoundParameters.ContainsKey('rating')) {

                $jsonParams | Add-Member -MemberType NoteProperty -Name 'rating' -Value $rating
            }
            if ($PSBoundParameters.ContainsKey('userNotes')) {

                $jsonParams | Add-Member -MemberType NoteProperty -Name 'notes' -Value $userNotes
            }

            $stringParam = $jsonParams | ConvertTo-Json -Compress

            Write-Verbose "jsonParams are: $stringParam"

            # --- Make the REST Call
            $body = @{
                apiKey   = $Script:BricksetConnection.apiKey
                userHash = $Script:BricksetConnection.userHash
                params   = $stringParam
                setID    = $setId
            }

            Write-Verbose "Body is: $($body | ConvertTo-Json -Depth 5)"

            Invoke-BricksetRestMethod -Method POST -URI '/setCollection' -Body $body
        }
    }
    catch [Exception] {

        throw
    }
}