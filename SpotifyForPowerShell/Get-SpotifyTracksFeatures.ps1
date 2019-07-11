function Get-SpotifyTracksFeatures {
    <#
        .SYNOPSIS
            This function will get audio features for multiple tracks based on Spotify Id's
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyTracksFeatures -Tracks "3f9Mzvd3URfbbIJBX4pz9Z","5m9Oa79lqWTRxTmHjbxOX3"
            
        .PARAMETER Tracks
            Required. String array of up to 100 track id's.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)] [array] $Tracks,

        [string] $Auth
    )

    $Tracks = [string]::Join(",", $Tracks)

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/audio-features?ids=$Tracks"
        
    $features = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
    return $features
}