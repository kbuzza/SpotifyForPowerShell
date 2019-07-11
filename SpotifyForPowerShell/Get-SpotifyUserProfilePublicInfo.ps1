function Get-SpotifyUserProfilePublicInfo {
    <#
        .SYNOPSIS
            This function will return public profile info about a Spotify user
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyUserProfilePublicInfo -Id "yaboybuzza"
            
        .PARAMETER Id
            Required. String representation of user id.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)] [string] $Id,

        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/users/$Id"
        
    $user = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
    return $user
}