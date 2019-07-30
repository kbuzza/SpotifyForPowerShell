function Get-SpotifyPlayerRecentlyPlayed {
    <#
        .SYNOPSIS
            This function will pause current playback.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyPlayerRecentlyPlayed -Auth $Auth -Limit 50

        .PARAMETER Limit
            Optional. Maximum number of items to return.

        .PARAMETER Before
            Optional. A unix timestamp string in milliseconds. Returns all items before
            (but not including) this cursor positon.

        .PARAMETER After
            Optional. A unix timestamp string in milliseconds. Returns all items after
            (but not including) this cursor positon.

        NOTE: Only 'Before' or 'After' can be specified, not both.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $false)]
        [ValidateRange(1,50)]
        [string] $Limit = 20,

        [Parameter(Mandatory = $false)]
        [string] $Before,

        [Parameter(Mandatory = $false)]
        [string] $After,

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    $uri = "https://api.spotify.com/v1/me/player/recently-played?limit=$Limit"

    if ($Before) {
        $uri += "&before=$Before"
    } 
    
    if ($After) {
        $uri += "&after=$After"
    }

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
        
    Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
}