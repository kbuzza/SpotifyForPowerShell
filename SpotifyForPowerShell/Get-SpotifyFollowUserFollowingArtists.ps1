function Get-SpotifyFollowUserFollowingArtists {
    <#
        .SYNOPSIS
            This function will return the current user's follow artists.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyFollowUserFollowingArtists -Auth $Auth -All 

        .PARAMETER Limit
            Optional. Between 1 and 50. Maximum number of items to return.

        .PARAMETER After
            Optional. The last artist ID retrieved from the previous request.

        .PARAMETER All
            Optional. When this parameter is used, every artist the user is following is returned.

        
        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $false)]
        [ValidateRange(1,50)]
        [int] $limit = 20,

        [Parameter(Mandatory = $false)]
        [string] $After,

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

    $artists = @()

    if ($All) {
        $uri = "https://api.spotify.com/v1/me/following?type=artist&limit=50"

        do {
            $query = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
            $uri = $query.artists.next

            foreach ($item in $query.artists.items) {
                $artists += $item
            }
        } while ($uri)
    } else {
        $uri = "https://api.spotify.com/v1/me/following?type=artist&limit=$Limit"
        
        if ($After) {
            $uri += "&after=$After"
        }

        $artists = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
        $artists = $artists.artists.items
    }
    
    return $artists
}