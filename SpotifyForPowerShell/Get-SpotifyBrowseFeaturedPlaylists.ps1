function Get-SpotifyBrowseFeaturedPlaylists {
    <#
        .SYNOPSIS
            This function will return a list of featured playlists in Spotify.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyBrowseFeaturedPlaylists -Auth $Auth -All

        .PARAMETER Timestamp
            Optional. Timestamp string in ISO 8601 format to get results for a specific time and day.
            
            Format: yyyy-MM-DDTHH:mm:ss
            Example: "2014-10-23T09:00:00
            
        .PARAMETER Offset
            Optional. Must be between 0 and 10000. Represents the starting point of the search.

        .PARAMETER Limit
            Optional. Must be between 1 and 50. Represents the number of playlists to return.

        .PARAMETER All
            Optional. When this parameter is used, every playlist will be returned.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $false)]
        [string] $Timestamp,

        [Parameter(Mandatory = $false)]
        [ValidateRange(0,10000)]
        [int] $Offset = 0,

        [Parameter(Mandatory = $false)]
        [ValidateRange(1,50)]
        [int] $Limit = 20,

        [Parameter(Mandatory = $false)]
        [switch] $All = $false,

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $playlists = @()
    
    if ($All) {
        $uri = "https://api.spotify.com/v1/browse/featured-playlists?offset=0&limit=50"

        if ($Timestamp) {
            $uri += "&timestamp=$Timestamp"
        }

        do {
            $query = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
            $uri = $query.playlists.next

            foreach ($item in $query.playlists.items) {
                $playlists += $item
            }
        } while ($uri)
    } else {
        $uri = "https://api.spotify.com/v1/browse/featured-playlists?offset=$Offset&limit=$Limit"
        
        if ($Timestamp) {
            $uri += "&timestamp=$Timestamp"
        }
        
        $playlists = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
        $playlists = $playlists.playlists.items
    }

    return $playlists
}