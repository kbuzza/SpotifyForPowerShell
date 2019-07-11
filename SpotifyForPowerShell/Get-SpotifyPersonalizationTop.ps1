function Get-SpotifyPersonalizationTop {
    <#
        .SYNOPSIS
            This function will return the current user's top artists or tracks.
    
        .EXAMPLE
            C:\Users\kbuzz> $items = Get-SpotifyPersonalizationTop -Type "tracks" -Offset 0 -Limit 50 -TimeRange "long_term" -All
            
        .PARAMETER Type
            Required. Type of entity to return: artists or tracks.

        .PARAMETER Offset
            Optional. Must be between 0 and 10000. Represents the starting point of the search, with an offset of 0 meaning
            the top.

        .PARAMETER Limit
            Optional. Must be between 1 and 50. Represents the number of tracks or artists to return.

        .PARAMETER TimeRange
            Optional. Time frame affinities are calculated over.
                long_term: several years w/ all new data
                medium_term: approximately last 6 months
                short_term: approximately last 4 weeks

        .PARAMETER All
            Optional. When this parameter is used, every one of the top tracks or albums are returned.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)] [ValidateSet("artists","tracks")] [string] $Type,

        [ValidateRange(0,10000)] [int] $Offset = 0,

        [ValidateRange(1,50)] [int] $Limit = 20,

        [ValidateSet("long_term","medium_term","short_term")] [string] $TimeRange = "medium_term",

        [switch] $All = $false,

        [string] $Auth
    )
    
    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
        
    $items = @()
    
    if ($All) {
        $uri = "https://api.spotify.com/v1/me/top/"
        $uri += $Type
        $uri += "?offset=0&limit=50&time_range=$TimeRange"

        do {

            $query = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
            $uri = $query.next

            foreach ($item in $query.items) {
                $items += $item
            }
        } while ($uri)
    } else {
        $uri = "https://api.spotify.com/v1/me/top/"
        $uri += $Type
        $uri += "?offset=$Offset&limit=$Limit&time_range=$TimeRange"

        $items = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
        $items = $items.items
    }

    return $items
}