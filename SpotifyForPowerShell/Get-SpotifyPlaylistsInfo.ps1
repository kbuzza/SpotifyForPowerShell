function Get-SpotifyPlaylistsInfo {
    <#
        .SYNOPSIS
            This function will return Spotify catalog info for a playlist.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyPlaylistsPlaylist -Id "5mFbFhHahoLBsF7FUFTb4l"
            
        .PARAMETER Id
            Required. String representation of playlist id.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)] [string] $Id,

        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/playlists/$Id"
        
    $playlist = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
    return $playlist
}