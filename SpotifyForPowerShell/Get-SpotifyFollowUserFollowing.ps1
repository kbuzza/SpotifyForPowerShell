function Get-SpotifyFollowUserFollowing {
    <#
        .SYNOPSIS
            This function will return an array of boolean values corresponding to which users follow a playlist.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyFollowUserFollowing -PlaylistId 
            
        .PARAMETER PlaylistId
            Required. The Spotify ID of the playlist.

        .PARAMETER Ids
            Required. Maximum of 5. Comma separated list of Spotify user IDs.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)]
        [string] $PlaylistId,

        [Parameter(Mandatory = $true)]
        [array] $Ids,

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    if ($Ids.Count -gt 5) {
        return $null
    }

    $Ids = [string]::Join(",", $Ids)

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/playlists/$PlaylistId/followers/contains?ids=$Ids"
        
    $bools = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}

    return $bools
}