function Remove-SpotifyPlaylistsTracks {
    <#
        .SYNOPSIS
            This function allows the user to delete tracks from a playlist.
    
        .EXAMPLE
            C:\Users\kbuzz> Remove-SpotifyPlaylistsTracks -Id "5mFbFhHahoLBsF7FUFTb4l" -Tracks "5m9Oa79lqWTRxTmHjbxOX3","3f9Mzvd3URfbbIJBX4pz9Z"
            
        .PARAMETER Id
            Required. String representation of playlist id.
        
        .PARAMETER Tracks
            Required. Array of track id's to be deleted.
        
        .PARAMETER SnapshotId
            Optional. The playlist’s snapshot ID against which changes are made.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)] [string] $Id,

        [Parameter(Mandatory = $true)] [array] $Tracks,

        [string] $SnapshotId,

        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/playlists/$Id/tracks"

    if ($null -eq $Tracks -or $Tracks.Length -eq 0) {
        $body = "{""tracks"":[]"
    } else {
        $body = "{""tracks"":["
        
        for ($i = 0; $i -lt $Tracks.Length; $i++) {
            if ($i -eq 0) {
                $body += "{""uri"":""spotify:track:" + $Tracks[$i] + """}"
            } else {
                $body += ",{""uri"":""spotify:track:" + $Tracks[$i] + """}"
            }
        }
        $body += "]"

    }

    if ($SnapshotId) {
        $body += ",""snapshot_id""=""$SnapshotId""}"
    } else {
        $body += "}"
    }

    $newSnapshotId = Invoke-RestMethod -Uri $uri -Method Delete -Headers @{Authorization="Bearer $AuthToken"} -Body $body
    return $newSnapshotId
}