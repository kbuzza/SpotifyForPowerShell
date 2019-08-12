function Invoke-SpotifyMusicalChairs {
    <#
        .SYNOPSIS
            This function will run a game of musical chairs based on a spotify playlist.
    
        .EXAMPLE
            C:\Users\kbuzz> Invoke-SpotifyMusicalChairs -PlaylistUri "spotify:playlist:5mFbFhHahoLBsF7FUFTb4l" -NumberOfPlayers 10 -DelayBetweenPlays 20 -MinPlayTime 10 -MaxPlayTime 30

        .PARAMETER PlaylistUri
            Required. Spotify playlist uri of the playlist to use for playback.
        
        .PARAMETER NumberOfPlayers
            Required. Number of players in the game of musical chairs.
        
        .PARAMETER DelayBetweenPlays
            Optional. Default 30 seconds. Time (in seconds) to delay between the stop of playback after a player is
            out and restarting the playback.

        .PARAMETER MinPlayTime
            Optional. Default 5 seconds. Minimum number of seconds the music will play at a time.
        
        .PARAMETER MaxPlayTime
            Optional. Default 20 seconds. Maximum number of seconds the music will play at a time.

        .PARAMETER Shuffle
            Optional. Default false. If selected, the playlist will be set to shuffle.
        
        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)]
        [string] $PlaylistUri,

        [Parameter(Mandatory = $true)]
        [int] $NumberOfPlayers,

        [Parameter(Mandatory = $false)]
        [int] $DelayBetweenPlays = 30,

        [Parameter(Mandatory = $false)]
        [int] $MinPlayTime = 5,

        [Parameter(Mandatory = $false)]
        [int] $MaxPlayTime = 20,

        [Parameter(Mandatory = $false)]
        [switch] $Shuffle,

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }

    Set-SpotifyPlayerPlay -ContextUri $PlaylistUri -Auth $AuthToken
    Set-SpotifyPlayerPause -Auth $AuthToken
    
    if ($Shuffle) {
        Set-SpotifyPlayerShuffle -State $true -Auth $AuthToken
    } else {
        Set-SpotifyPlayerShuffle -State $false -Auth $AuthToken
    }

    for (; $NumberOfPlayers -gt 1; $NumberOfPlayers--) {
        Set-SpotifyPlayerPlay -Auth $AuthToken
        Start-Sleep -Seconds (Get-Random -Minimum $MinPlayTime -Maximum ($MaxPlayTime + 1))

        Set-SpotifyPlayerPause -Auth $AuthToken
        Start-Sleep -Seconds $DelayBetweenPlays
    }
}