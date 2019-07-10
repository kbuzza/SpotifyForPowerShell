function Get-SpotifyUserProfilePublicInfo {
    <#
        .SYNOPSIS
            This function will return public profile info about a Spotify user
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyUserProfilePublicInfo -Id "yaboybuzza"
            
        .PARAMETER Id
            Required. String representation of user id.
    #>

    param (
        [Parameter(Mandatory = $true)] [string] $Id
    )

    $AuthToken = Get-SpotifyAuthorizationToken

    $uri = "https://api.spotify.com/v1/users/$Id"
        
    $user = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
    return $user
}