function Get-SpotifyBrowseRecommendationGenres {
    <#
        .SYNOPSIS
            This function will return a list of available genres seed parameter values for recommendations.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyBrowseRecommendationGenres -Auth $Auth

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/recommendations/available-genre-seeds"
    
    $genres = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"} 

    return $genres.genres
}