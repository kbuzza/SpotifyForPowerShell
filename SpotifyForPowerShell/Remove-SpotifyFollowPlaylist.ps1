function Remove-SpotifyFollowPlaylist {
    <#
        .SYNOPSIS
            This function will remove the current user as the follower

        .EXAMPLE
            C:\Users\kbuzz> Remove-SpotifyFollowPlaylist -PlaylistId "5mFbFhHahoLBsF7FUFTb4l"
            
        .PARAMETER PlaylistId
            Required. The Spotify ID of the playlist.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)] [string] $PlaylistId,

        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/playlists/$PlaylistId/followers"
        
    $query = Invoke-RestMethod -Uri $uri -Method Delete -Headers @{Authorization="Bearer $AuthToken"}

    return $query
}