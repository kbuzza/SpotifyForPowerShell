function Remove-SpotifyLibraryTracks {
    <#
        .SYNOPSIS
            This function will delete a list of tracks by their corresponding track id's in the user's library
    
        .EXAMPLE
            C:\Users\kbuzz> Remove-SpotifyLibraryTracks -Tracks "3f9Mzvd3URfbbIJBX4pz9Z","5m9Oa79lqWTRxTmHjbxOX3"
            
        .PARAMETER Tracks
            Required. String array of up to 50 track id's.
    #>

    param (
        [Parameter(Mandatory = $true)] [array] $Tracks
    )

    $Tracks = [string]::Join(",", $Tracks)

    $AuthToken = Get-SpotifyAuthorizationToken

    $uri = "https://api.spotify.com/v1/me/tracks?ids=$Tracks"
        
    Invoke-RestMethod -Uri $uri -Method Delete -Headers @{Authorization="Bearer $AuthToken"}
}