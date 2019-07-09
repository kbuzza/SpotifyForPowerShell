function Get-SpotifyPlaylistsPlaylistPhoto {
    <#
        .SYNOPSIS
            This function will return info for a playlist's cover photo.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyPlaylistsPlaylistPhoto -Id "5mFbFhHahoLBsF7FUFTb4l"
            
        .PARAMETER Id
            Required. String representation of playlist id.
    #>

    param (
        [Parameter(Mandatory = $true)] [string] $Id
    )

    $AuthToken = Get-SpotifyAuthorizationToken

    $uri = "https://api.spotify.com/v1/playlists/$Id/images"
        
    $photo = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
    return $photo
}