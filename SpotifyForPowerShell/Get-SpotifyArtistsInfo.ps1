function Get-SpotifyArtistsInfo {
    <#
        .SYNOPSIS
            This function will return Spotify catalog info for artists.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyArtistsInfo -Artists "3Gm5F95VdRxW3mqCn8RPBJ","1t20wYnTiAT0Bs7H1hv9Wt"

        .PARAMETER Artists
            Required. String array of up to 50 artist id's.
    #>

    param (
        [Parameter(Mandatory = $true)] [array] $Artists
    )

    $Artists = [string]::Join(",", $Artists)

    $AuthToken = Get-SpotifyAuthorizationToken

    $uri = "https://api.spotify.com/v1/artists?ids=$Artists"

    $artist = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"} 
    $artist = $artist.artists

    return $artist
}