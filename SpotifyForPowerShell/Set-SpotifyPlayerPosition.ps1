function Set-SpotifyPlayerPosition {
    <#
        .SYNOPSIS
            This function will set the position of the current track.
    
        .EXAMPLE
            C:\Users\kbuzz> Set-SpotifyPlayerPosition -Auth $Auth -Position 10000

        .PARAMETER Position
            Required. Position in milliseconds to seek to. A value greater than the length
            of the song will skip to the next song.

        .PARAMETER DeviceId
            Optional. The id of the device this command is targeting.

        .PARAMETER SkipSong
            Optional. When used, the current song will be skipped.

        .PARAMETER Auth
            Optional. A continuation authorization token.
        
    #>

    param (
        [Parameter(Mandatory = $true)] [ValidateRange(1,[int]::MaxValue)] [int] $Position,

        [string] $DeviceId,

        [switch] $SkipSong = $false,

        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }

    if ($SkipSong) {
        $Position = 7200000
    }
    
    $uri = "https://api.spotify.com/v1/me/player/seek?position_ms=$Position"

    if ($DeviceId) {
        $uri += "&device_id=$DeviceId"
    }
        
    Invoke-RestMethod -Uri $uri -Method Put -Headers @{Authorization="Bearer $AuthToken"}
}