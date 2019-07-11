function Set-SpotifyPlaylistsReorder {
    <#
        .SYNOPSIS
            This function allows the user to alter the track order of a playlist.
    
        .EXAMPLE
            C:\Users\kbuzz> Set-SpotifyPlaylistsReorder -Id "5mFbFhHahoLBsF7FUFTb4l" -RangeStart 2 -RangeLength 2 -InsertBefore 0
            
        .PARAMETER Id
            Required. String representation of playlist id.
        
        .PARAMETER RangeStart
            Required. Position of the first track to be reordered.
        
        .PARAMETER InsertBefore
            Required. Position where the tracks should be inserted.

        .PARAMETER RangeLength
            Optional. Number of tracks to be reordered. Default is 1.
    
        .PARAMETER SnapshotId
            Optional. Playlist's snapshot id against which the changes are made.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)] [string] $Id,

        [Parameter(Mandatory = $true)] [int] $RangeStart,

        [Parameter(Mandatory = $true)] [int] $InsertBefore,

        [int] $RangeLength = 1,

        [string] $SnapshotId,

        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/playlists/$Id/tracks"

    
    $body = "{""range_start"":$RangeStart,""insert_before"":$InsertBefore,""range_length"":$RangeLength"
    
    if ($SnapshotId) {
        $body += ",""snapshot_id"":""$SnapshotId"""
    }
    $body += "}"

    $newSnapshotId = Invoke-RestMethod -Uri $uri -Method Put -Headers @{Authorization="Bearer $AuthToken"} -Body $body
    return $newSnapshotId
}