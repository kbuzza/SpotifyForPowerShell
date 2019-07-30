function Get-SpotifyLibraryTracksContains {
    <#
        .SYNOPSIS
            This function will return an array of boolean values corresponding to which track id's in the tracks parameter
            are in the user's library.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyLibraryTracksContains -Tracks "3f9Mzvd3URfbbIJBX4pz9Z","5m9Oa79lqWTRxTmHjbxOX3"
            
        .PARAMETER Tracks
            Required. String array of up to 50 track id's.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)]
        [array] $Tracks,

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    $Tracks = [string]::Join(",", $Tracks)

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/me/tracks/contains?ids=$Tracks"
        
    $bools = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
    
    return $bools
}