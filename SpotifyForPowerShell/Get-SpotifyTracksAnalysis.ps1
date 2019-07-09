function Get-SpotifyTracksAnalysis {
    <#
        .SYNOPSIS
            This function will return audio analysis info for a track.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyTracksAnalysis -Id "3f9Mzvd3URfbbIJBX4pz9Z"

        .PARAMETER Id
            Required. The spotify id for the track.
    #>

    param (
        [Parameter(Mandatory=$true)] [string] $Id
    )

    $AuthToken = Get-SpotifyAuthorizationToken

    $uri = "https://api.spotify.com/v1/audio-analysis/$Id"
    
    $track = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"} 

    return $track
}