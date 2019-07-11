function Save-SpotifyPlaylistsTracks {
    <#
        .SYNOPSIS
            This function allows the user to add tracks to a playlist.
    
        .EXAMPLE
            C:\Users\kbuzz> Save-SpotifyPlaylistsTracks -Id "5mFbFhHahoLBsF7FUFTb4l" -Position 3 -Tracks "5m9Oa79lqWTRxTmHjbxOX3","3f9Mzvd3URfbbIJBX4pz9Z"
            
        .PARAMETER Id
            Required. String representation of playlist id.
        
        .PARAMETER Tracks
            Required. Array of track id's to be added.
        
        .PARAMETER Position
            Optional. Position to insert the tracks into in order.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)] [string] $Id,

        [Parameter(Mandatory = $true)] [array] $Tracks,

        [int] $Position = 0,

        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/playlists/$Id/tracks?position=$Position"

    if ($null -eq $Tracks -or $Tracks.Length -eq 0) {
        $body = "{""uris"":[]}"
    } else {
        $body = "{""uris"":["
        
        for ($i = 0; $i -lt $Tracks.Length; $i++) {
            if ($i -eq 0) {
                $body += """spotify:track:" + $Tracks[$i] + """"
            } else {
                $body += ",""spotify:track:" + $Tracks[$i] + """"
            }
        }

        $body += "]}"
    }

    $newSnapshotId = Invoke-RestMethod -Uri $uri -Method Post -Headers @{Authorization="Bearer $AuthToken"} -Body $body
    return $newSnapshotId
}