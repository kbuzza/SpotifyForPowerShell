function Get-SpotifyBrowseNewReleases {
    <#
        .SYNOPSIS
            This function will return a list of new album releases featured in Spotify.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyBrowseNewReleases -Auth $Auth -All
            
        .PARAMETER Offset
            Optional. Must be between 0 and 10000. Represents the starting point of the search.

        .PARAMETER Limit
            Optional. Must be between 1 and 50. Represents the number of albums to return.

        .PARAMETER All
            Optional. When this parameter is used, every album will be returned.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [ValidateRange(0,10000)] [int] $Offset = 0,

        [ValidateRange(1,50)] [int] $Limit = 20,

        [switch] $All = $false,

        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $albums = @()
    
    if ($All) {
        $uri = "https://api.spotify.com/v1/browse/new-releases?offset=0&limit=50"
        do {
            $query = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
            $uri = $query.albums.next

            foreach ($item in $query.albums.items) {
                $albums += $item
            }

        } while ($uri)
    } else {

        $uri = "https://api.spotify.com/v1/browse/new-releases?offset=$Offset&limit=$Limit"
        
        $albums = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
        $albums = $albums.albums.items
    }

    return $albums
}