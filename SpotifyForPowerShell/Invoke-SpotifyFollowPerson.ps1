function Invoke-SpotifyFollowPerson {
    <#
        .SYNOPSIS
            This function will add the current user as a follower of one or more artists or other Spotify users.
    
        .EXAMPLE
            C:\Users\kbuzz> Invoke-SpotifyFollowPerson -Type "user" -Ids "yaboybuzza"
            
        .PARAMETER Type
            Required. The ID type: either "artist" or "user".

        .PARAMETER Ids
            Required. Maximum of 50. Comma separated list of artist or user Spotify ID strings.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet("artist","user")]
        [string] $Type,

        [Parameter(Mandatory = $true)]
        [array] $Ids,

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    $Ids = [string]::Join(",", $Ids)

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/me/following?type=$Type&ids=$Ids"
        
    $query = Invoke-RestMethod -Uri $uri -Method Put -Headers @{Authorization="Bearer $AuthToken"}

    return $query
}