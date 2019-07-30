function Get-SpotifyArtistsAlbums {
    <#
        .SYNOPSIS
            This function will return Spotify catalog info for an artist's albums.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyArtistsAlbums -Id "1t20wYnTiAT0Bs7H1hv9Wt" -All
            
        .PARAMETER Id
            Required. String representation of artist id.

        .PARAMETER Offset
            Optional. Must be between 0 and 10000. Represents the starting point of the search, with an offset of 0 meaning
            the most recent album.

        .PARAMETER Limit
            Optional. Must be between 1 and 50. Represents the number of albums to return.

        .PARAMETER All
            Optional. When this parameter is used, every one of the artist's albums are returned.
    #>

    param (
        [Parameter(Mandatory = $true)]
        [string] $Id,

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

    $albums = @()
    
    if ($All) {
        $uri = "https://api.spotify.com/v1/artists/$Id/albums?offset=0&limit=50"

        do {
            $query = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
            $uri = $query.next

            foreach ($item in $query.items) {
                $albums += $item
            }
        } while ($uri)
    } else {
        $uri = "https://api.spotify.com/v1/artists/$Id/albums?offset=$Offset&limit=$Limit"
        
        $albums = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
        $albums = $albums.items
    }

    return $albums
}