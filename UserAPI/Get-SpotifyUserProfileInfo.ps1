function Get-SpotifyUserProfileInfo {
    <#
        .SYNOPSIS
            This function returns detailed profile info about the current user.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyUserProfileInfo

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
    
    $uri = "https://api.spotify.com/v1/me"
        
    $user = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
    
    return $user
}