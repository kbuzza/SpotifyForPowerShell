function Save-SpotifyLibraryTracks {
    <#
        .SYNOPSIS
            This function will save a list of tracks by their corresponding track id's in the user's library
    
        .EXAMPLE
            C:\Users\kbuzz> Save-SpotifyLibraryTracks -Tracks "3f9Mzvd3URfbbIJBX4pz9Z","5m9Oa79lqWTRxTmHjbxOX3"
            
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
    
    $uri = "https://api.spotify.com/v1/me/tracks?ids=$Tracks"
        
    Invoke-RestMethod -Uri $uri -Method Put -Headers @{Authorization="Bearer $AuthToken"}
}