function Get-SpotifyLibraryAlbumsContains {
    <#
        .SYNOPSIS
            This function will return an array of boolean values corresponding to which album id's in the albums parameter
            are in the user's library.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyLibraryAlbumsContains -Albums "1DNx0H5ZX1ax3yyRwtgT4S","1jt1QnxmTsGnQVZIVlDtRT"
            
        .PARAMETER Albums
            Required. String array of up to 50 album id's.
    #>

    param (
        [Parameter(Mandatory = $true)] [array] $Albums
    )

    $Albums = [string]::Join(",", $Albums)

    $AuthToken = Get-SpotifyAuthorizationToken

    $uri = "https://api.spotify.com/v1/me/albums/contains?ids=$Albums"
        
    $bools = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
    return $bools
}