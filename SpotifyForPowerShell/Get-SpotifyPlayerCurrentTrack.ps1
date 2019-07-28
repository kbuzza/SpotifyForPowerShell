function Get-SpotifyPlayerCurrentTrack {
    <#
        .SYNOPSIS
            This function will return iformation about a user's current devices
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyPlayerCurrentTrack

        .PARAMETER Auth
            Optional. A continuation authorization token.
        
    #>

    param (
        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/me/player/currently-playing"
        
    $track = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
    
    return $track
}