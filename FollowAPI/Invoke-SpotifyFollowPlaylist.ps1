function Invoke-SpotifyFollowPlaylist {
    <#
        .SYNOPSIS
            This function will add the current user as a follower of a playlist.

        .EXAMPLE
            C:\Users\kbuzz> Invoke-SpotifyFollowPlaylist -PlaylistId "5mFbFhHahoLBsF7FUFTb4l" -Public $true 
            
        .PARAMETER PlaylistId
            Required. The Spotify ID of the playlist.

        .PARAMETER Public
            Optional. Default true. Boolean to determine whether the playlist will dsplay as public or private on the user's profile.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)]
        [string] $PlaylistId,

        [Parameter(Mandatory = $false)]
        [bool] $Public = $true,

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    if ($Public) {
        $body = "{""public"":true}"
    } else {
        $body = "{""public"":false}"
    }
    
    $uri = "https://api.spotify.com/v1/playlists/$PlaylistId/followers"
        
    $query = Invoke-RestMethod -Uri $uri -Method Put -Headers @{Authorization="Bearer $AuthToken"} -Body -$body

    return $query
}