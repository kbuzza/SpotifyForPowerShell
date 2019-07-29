function Invoke-SpotifyPlayerTransferPlayback {
    <#
        .SYNOPSIS
            This function will transfer playback to a new connected device.
    
        .EXAMPLE
            C:\Users\kbuzz> Invoke-SpotifyPlayerTransferPlayback -DeviceId "fa364b4ea3739727ff2906e0b43d9153aa1d4707"

        .PARAMETER DeviceId
            Required. Id of the device on which playback should be started/transferred.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)]
        [string] $DeviceId,

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/me/player"

    $body = "{""device_ids"":[""$DeviceId""]}"
    
    $playback = Invoke-RestMethod -Uri $uri -Method Put -Headers @{Authorization="Bearer $AuthToken"} -Body $body
    
    return $playback
}