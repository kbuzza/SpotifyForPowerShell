function Get-SpotifyBrowseCategoryInfo {
    <#
        .SYNOPSIS
            This function will return info for a single category used to tag items in Spotify.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyBrowseCategoryInfo -Id "toplists"

        .PARAMETER Id
            Required. The spotify id for the category.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory=$true)]
        [string] $Id,

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/browse/categories/$Id"
    
    $category = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"} 

    return $category
}