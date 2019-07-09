function Get-SpotifyAlbumsInfo {
    <#
        .SYNOPSIS
            This function will return Spotify catalog info for albums.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyAlbumsInfo -Albums "6E8WvkEF5UzumaYErKuv3W","6VhDYmsjHqRxKXd0z7hmXI"

        .PARAMETER Albums
            Required. String array of up to 20 album id's.
    #>

    param (
        [Parameter(Mandatory = $true)] [array] $Albums
    )

    $Albums = [string]::Join(",", $Albums)

    $AuthToken = Get-SpotifyAuthorizationToken

    $uri = "https://api.spotify.com/v1/albums?ids=$Albums"

    $album = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"} 

    return $album
}