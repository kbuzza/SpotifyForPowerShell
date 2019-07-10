function Get-SpotifyArtistsRelatedArtists {
    <#
        .SYNOPSIS
            This function will return Spotify catalog info for an artist's related artists.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyArtistsRelatedArtists -Id "1t20wYnTiAT0Bs7H1hv9Wt"
            
        .PARAMETER Id
            Required. String representation of artist id.
    #>

    param (
        [Parameter(Mandatory = $true)] [string] $Id
    )

    $AuthToken = Get-SpotifyAuthorizationToken

    $uri = "https://api.spotify.com/v1/artists/$Id/related-artists"
        
    $tracks = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
    return $tracks
}