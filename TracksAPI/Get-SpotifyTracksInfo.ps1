function Get-SpotifyTracksInfo {
    <#
        .SYNOPSIS
            This function will return Spotify catalog info for tracks.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyTracksInfo -Tracks "3f9Mzvd3URfbbIJBX4pz9Z","5m9Oa79lqWTRxTmHjbxOX3"

        .PARAMETER Tracks
            Required. String array of up to 50 track id's.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)]
        [array] $Tracks,

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    $Tracks = [string]::Join(",", $Tracks)

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/tracks?ids=$Tracks"

    $track = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"} 

    return $track
}