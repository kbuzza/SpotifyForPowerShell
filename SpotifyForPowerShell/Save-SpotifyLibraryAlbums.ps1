function Save-SpotifyLibraryAlbums {
    <#
        .SYNOPSIS
            This function will save a list of albums by their corresponding track id's in the user's library
    
        .EXAMPLE
            C:\Users\kbuzz> Save-SpotifyLibraryAlbums -Albums "1DNx0H5ZX1ax3yyRwtgT4S","1jt1QnxmTsGnQVZIVlDtRT"
            
        .PARAMETER Albums
            Required. String array of up to 50 album id's.
    #>

    param (
        [Parameter(Mandatory = $true)] [array] $Albums
    )

    $Albums = [string]::Join(",", $Albums)

    $AuthToken = Get-SpotifyAuthorizationToken

    $uri = "https://api.spotify.com/v1/me/albums?ids=$Albums"
        
    Invoke-RestMethod -Uri $uri -Method Put -Headers @{Authorization="Bearer $AuthToken"}
}