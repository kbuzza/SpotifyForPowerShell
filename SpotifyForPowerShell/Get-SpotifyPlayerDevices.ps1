function Get-SpotifyPlayerDevices {
    <#
        .SYNOPSIS
            This function will return iformation about a user's current devices
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyPlayerDevices

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/me/player/devices"
        
    $devices = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
    
    return $devices.devices
}