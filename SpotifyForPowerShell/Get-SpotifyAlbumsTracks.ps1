function Get-SpotifyAlbumsTracks {
    <#
        .SYNOPSIS
            This function will return Spotify catalog info for tracks in an album.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyAlbumsTracks -Id "6E8WvkEF5UzumaYErKuv3W" -All
            
        .PARAMETER Id
            Required. String representation of album id.

        .PARAMETER Offset
            Optional. Must be between 0 and 10000. Represents the starting point of the search, with an offset of 0 meaning
            the first track in the album.

        .PARAMETER Limit
            Optional. Must be between 1 and 50. Represents the number of tracks to return.

        .PARAMETER All
            Optional. When this parameter is used, every track in the album will be returned.
    #>

    param (
        [Parameter(Mandatory = $true)] [string] $Id,

        [ValidateRange(0,10000)] [int] $Offset = 0,

        [ValidateRange(1,100)] [int] $Limit = 20,

        [switch] $All = $false
    )

    $AuthToken = Get-SpotifyAuthorizationToken

    $tracks = @()
    
    if ($All) {

        $uri = "https://api.spotify.com/v1/albums/$Id/tracks?offset=0&limit=100"
        do {

            $query = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
            $uri = $query.next

            foreach ($item in $query.items) {
                $tracks += $item
            }
        } while ($uri)
    } else {
        $uri = "https://api.spotify.com/v1/albums/$Id/tracks?offset=$Offset&$Limit=100"
        
        $tracks = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
        $tracks = $tracks.items

    }

    return $tracks
}