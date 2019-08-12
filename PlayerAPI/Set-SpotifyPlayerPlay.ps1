function Set-SpotifyPlayerPlay {
    <#
        .SYNOPSIS
            This function will start a new context or resume current playback on the user's active device.
    
        .EXAMPLE
            C:\Users\kbuzz> Set-SpotifyPlayerPlay -Auth $a -ContextUri "spotify:album:06uilmMkjOIuifxVYJyqwD" -PositionInMilliseconds 100000 -Offset 3 

        .PARAMETER DeviceId
            Optional. The id of the device this command is targeting.

        .PARAMETER ContextUri
            Optional. Context uri to start playback in.

        .PARAMETER PositionInMilliseconds
            Optional. Position in milliseconds to start the first track in the playback.

            Note: If value is greater than the length of the first track, the first track will be automatically skipped.

        .PARAMETER Offset
            Optional. Offset to start playback in.

            Note: Using offset without context is not allowed.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $false)]
        [string] $DeviceId,

        [Parameter(Mandatory = $false)]
        [string] $ContextUri,

        [Parameter(Mandatory = $false)]
        [int] $PositionInMilliseconds,

        [Parameter(Mandatory = $false)]
        [int] $Offset,

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }

    $uri = "https://api.spotify.com/v1/me/player/play"

    if ($DeviceId) {
        $uri += "?device_id=$DeviceId"
    }

    $body = "{"

    if ($ContextUri) {
        $body += """context_uri"":""$ContextUri"","
    }

    if ($PositionInMilliseconds) {
        $body += """position_ms"":$PositionInMilliseconds,"
    }

    if ($Offset) {
        $body += """offset"":{""position"":$Offset},"
    }

    if ($body.Length -gt 1) {
        $body = $body.Substring(0, $body.Length - 1)
    }

    $body += "}"

    Invoke-RestMethod -Uri $uri -Method Put -Headers @{Authorization="Bearer $AuthToken"} -Body $body
}