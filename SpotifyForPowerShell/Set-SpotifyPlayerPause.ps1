function Set-SpotifyPlayerPause {
    <#
        .SYNOPSIS
            This function will pause current playback.
    
        .EXAMPLE
            C:\Users\kbuzz> Set-SpotifyPlayerPause

        .PARAMETER DeviceId
            Optional. The id of the device this command is targeting.

        .PARAMETER Auth
            Optional. A continuation authorization token.
        
    #>

    param (
        [string] $DeviceId,

        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }

    $uri = "https://api.spotify.com/v1/me/player/pause"

    if ($DeviceId) {
        $uri += "?device_id=$DeviceId"
    }
        
    Invoke-RestMethod -Uri $uri -Method Put -Headers @{Authorization="Bearer $AuthToken"}
}