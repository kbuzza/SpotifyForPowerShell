function Remove-SpotifyLibraryAlbums {
    <#
        .SYNOPSIS
            This function will delete a list of albums by their corresponding track id's in the user's library
    
        .EXAMPLE
            C:\Users\kbuzz> Remove-SpotifyLibraryAlbums -Albums "1DNx0H5ZX1ax3yyRwtgT4S","1jt1QnxmTsGnQVZIVlDtRT"
            
        .PARAMETER Albums
            Required. String array of up to 50 album id's.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)] [array] $Albums,

        [string] $Auth
    )

    $Albums = [string]::Join(",", $Albums)

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/me/albums?ids=$Albums"
        
    Invoke-RestMethod -Uri $uri -Method Delete -Headers @{Authorization="Bearer $AuthToken"}
}