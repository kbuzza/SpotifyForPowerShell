function Set-SpotifyPlayerVolume {
    <#
        .SYNOPSIS
            This function will set the volume of the current playback.
    
        .EXAMPLE
            C:\Users\kbuzz> Set-SpotifyPlayerVolume -VolumePercent 30 -DeviceId "b46689a4cd5"

        .PARAMETER VolumePercent
            Required. Must be between 0 and 100. Represents the volume percentage to set playback to.

        .PARAMETER DeviceId
            Optional. The id of the device this command is targeting.

        .PARAMETER Auth
            Optional. A continuation authorization token.
        
    #>

    param (
        [Parameter(Mandatory = $true)] [ValidateRange(0,100)] [int] $VolumePercent,

        [string] $DeviceId,

        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/me/player/volume?volume_percent=$VolumePercent"

    if ($DeviceId) {
        $uri += "&device_id=$DeviceId"
    }
        
    Invoke-RestMethod -Uri $uri -Method Put -Headers @{Authorization="Bearer $AuthToken"}
}