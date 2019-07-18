function Get-SpotifyFollowFollowingState {
    <#
        .SYNOPSIS
            This function will return an array of boolean values corresponding to which artists or users the current user follows.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyFollowFollowingState -Type "user" -Ids "yaboybuzza"
            
        .PARAMETER Type
            Required. The ID type: either "artist" or "user".

        .PARAMETER Ids
            Required. Comma separated list of artist or user Spotify ID strings.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)] [ValidateSet("artist","user")] [string] $Type,

        [Parameter(Mandatory = $true)] [array] $Ids,

        [string] $Auth
    )

    $Ids = [string]::Join(",", $Ids)

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/me/following/contains?type=$Type&ids=$Ids"
        
    $bools = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}

    return $bools
}