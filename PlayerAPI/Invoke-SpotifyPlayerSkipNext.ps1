function Invoke-SpotifyPlayerSkipNext {
    <#
        .SYNOPSIS
            This function will pause current playback.
    
        .EXAMPLE
            C:\Users\kbuzz> Invoke-SpotifyPlayerSkipNext

        .PARAMETER DeviceId
            Optional. The id of the device this command is targeting.

        .PARAMETER Auth
            Optional. A continuation authorization token.    
    #>

    param (
        [Parameter(Mandatory = $false)]
        [string] $DeviceId,

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }

    $uri = "https://api.spotify.com/v1/me/player/next"

    if ($DeviceId) {
        $uri += "?device_id=$DeviceId"
    }
        
    Invoke-RestMethod -Uri $uri -Method Post -Headers @{Authorization="Bearer $AuthToken"}
}