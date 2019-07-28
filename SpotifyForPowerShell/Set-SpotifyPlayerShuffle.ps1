function Set-SpotifyPlayerShuffle {
    <#
        .SYNOPSIS
            This function will set shuffle on or off for user playback.
    
        .EXAMPLE
            C:\Users\kbuzz> Set-SpotifyPlayerShuffle -State $true

        .PARAMETER State
            Required. True turns shuffle on, and false turns shuffle off.

        .PARAMETER DeviceId
            Optional. The id of the device this command is targeting.

        .PARAMETER Auth
            Optional. A continuation authorization token.
        
    #>

    param (
        [Parameter(Mandatory = $true)] [bool] $State,

        [string] $DeviceId,

        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }

    $uri = "https://api.spotify.com/v1/me/player/shuffle?state=$State"

    if ($DeviceId) {
        $uri += "&device_id=$DeviceId"
    }
        
    Invoke-RestMethod -Uri $uri -Method Put -Headers @{Authorization="Bearer $AuthToken"}
}