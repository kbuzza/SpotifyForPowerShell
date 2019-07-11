function Get-SpotifyArtistsTopTracks {
    <#
        .SYNOPSIS
            This function will return Spotify catalog info for an artist's top tracks.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyArtistsTopTracks -Id "1t20wYnTiAT0Bs7H1hv9Wt"
            
        .PARAMETER Id
            Required. String representation of artist id.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)] [string] $Id,

        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    $uri = "https://api.spotify.com/v1/artists/$Id/top-tracks?market=from_token"
        
    $tracks = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
    return $tracks
}