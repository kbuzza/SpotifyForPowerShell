function Get-SpotifyPlaylistsTracks {
    <#
        .SYNOPSIS
            This function will return Spotify catalog info for tracks in a playlist.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyPlaylistsTracks -Id "5mFbFhHahoLBsF7FUFTb4l" -All
            
        .PARAMETER Id
            Required. String representation of playlist id.

        .PARAMETER Offset
            Optional. Must be between 0 and 10000. Represents the starting point of the search, with an offset of 0 meaning
            the most recent saved track.

        .PARAMETER Limit
            Optional. Must be between 1 and 100. Represents the number of tracks to return.

        .PARAMETER All
            Optional. When this parameter is used, every track in the user's library will be returned.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)] [string] $Id,

        [ValidateRange(0,10000)] [int] $Offset = 0,

        [ValidateRange(1,100)] [int] $Limit = 100,

        [switch] $All = $false,

        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $tracks = @()
    
    if ($All) {

        $uri = "https://api.spotify.com/v1/playlists/$Id/tracks?offset=0&limit=100"
        do {

            $query = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
            $uri = $query.next

            foreach ($item in $query.items) {
                $tracks += $item
            }
        } while ($uri)
    } else {
        $uri = "https://api.spotify.com/v1/playlists/$Id/tracks?offset=$Offset&limit=$Limit"
        
        $tracks = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
        $tracks = $tracks.items

    }

    return $tracks
}