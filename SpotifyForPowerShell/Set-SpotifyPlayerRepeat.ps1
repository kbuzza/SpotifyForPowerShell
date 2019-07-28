function Set-SpotifyPlayerRepeat {
    <#
        .SYNOPSIS
            This function will set the repeat state for user playback.
    
        .EXAMPLE
            C:\Users\kbuzz> Set-SpotifyPlayerRepeat -State "track"

        .PARAMETER State
            Required. "track", "context", or "off". Turns repeat on for the track,
            turns repeat on for the context, or turns repeat off.

        .PARAMETER DeviceId
            Optional. The id of the device this command is targeting.

        .PARAMETER Auth
            Optional. A continuation authorization token.
        
    #>

    param (
        [Parameter(Mandatory = $true)] [ValidateSet("track","context","off")] [string] $State,

        [string] $DeviceId,

        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }

    $uri = "https://api.spotify.com/v1/me/player/repeat?state=$State"

    if ($DeviceId) {
        $uri += "&device_id=$DeviceId"
    }
        
    Invoke-RestMethod -Uri $uri -Method Put -Headers @{Authorization="Bearer $AuthToken"}
}