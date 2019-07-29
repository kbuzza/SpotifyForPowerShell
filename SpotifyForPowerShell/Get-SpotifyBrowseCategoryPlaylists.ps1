function Get-SpotifyBrowseCategoryPlaylists {
    <#
        .SYNOPSIS
            This function will return a list of Spotify playlists tagged with a particular category.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyBrowseCategoryPlaylists -Auth $Auth -Id "toplists" -Limit 10

        .PARAMETER Id
            Required. Spotify category id for the category.
            
        .PARAMETER Offset
            Optional. Must be between 0 and 10000. Represents the starting point of the search.

        .PARAMETER Limit
            Optional. Must be between 1 and 50. Represents the number of playlists to return.

        .PARAMETER All
            Optional. When this parameter is used, every playlist tagged with the category will be returned.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)]
        [string] $Id,

        [Parameter(Mandatory = $false)]
        [ValidateRange(0,10000)]
        [int] $Offset = 0,

        [Parameter(Mandatory = $false)]
        [ValidateRange(1,50)]
        [int] $Limit = 20,

        [Parameter(Mandatory = $false)]
        [switch] $All = $false,

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $playlists = @()
    
    if ($All) {
        $uri = "https://api.spotify.com/v1/browse/categories/$Id/playlists?offset=0&limit=50"

        do {
            $query = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
            $uri = $query.playlists.next

            foreach ($item in $query.playlists.items) {
                $playlists += $item
            }
        } while ($uri)
    } else {
        $uri = "https://api.spotify.com/v1/browse/categories/$Id/playlists?offset=$Offset&limit=$Limit"
        
        $playlists = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
        $playlists = $playlists.playlists.items
    }

    return $playlists
}