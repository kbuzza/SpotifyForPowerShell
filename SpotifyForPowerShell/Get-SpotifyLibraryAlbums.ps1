function Get-SpotifyLibraryAlbums {
    <#
        .SYNOPSIS
            This function will return Spotify catalog info for albums in the user's library.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyLibraryAlbums -Offset 20 -Limit 30
            C:\Users\kbuzz> Get-SpotifyLibraryAlbums -All
            
        .PARAMETER Offset
            Optional. Must be between 0 and 10000. Represents the starting point of the search, with an offset of 0 meaning
            the most recent saved album.

        .PARAMETER Limit
            Optional. Must be between 1 and 50. Represents the number of albums to return.

        .PARAMETER All
            Optional. When this parameter is used, every album in the user's library will be returned.

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

        $uri = "https://api.spotify.com/v1/me/albums?offset=0&limit=50"
        do {

            $query = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
            $uri = $query.next

            foreach ($item in $query.items) {
                $albums += $item
            }

        } while ($uri)
    } else {

        $uri = "https://api.spotify.com/v1/me/albums?offset=$offset&limit=$limit"
        
        $albums = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
        $albums = $albums.items

    }

    return $albums
}