function Get-SpotifyPlaylistsUserPlaylists {
    <#
        .SYNOPSIS
            This function will return Spotify catalog info for playlists in a user's library.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyPlaylistsUserPlaylists -Offset 20 -Limit 30 -UserId "yaboybuzza"
            
        .PARAMETER Offset
            Optional. Must be between 0 and 10000. Represents the starting point of the search, with an offset of 0 meaning
            the most recent saved playlist.

        .PARAMETER Limit
            Optional. Must be between 1 and 50. Represents the number of playlists to return.

        .PARAMETER All
            Optional. When this parameter is used, every playlist in a user's library will be returned.

        .PARAMETER UserId
            Optional. This parameter specifies a specific user to find playlists from. When this parameter
            is not used, the current user is selected.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $false)]
        [ValidateRange(0,10000)]
        [int] $Offset = 0,

        [Parameter(Mandatory = $false)]
        [ValidateRange(1,50)]
        [int] $Limit = 20,

        [Parameter(Mandatory = $false)]
        [switch] $All = $false,

        [Parameter(Mandatory = $false)]
        [string] $UserId,

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    if ($UserId) {
        $uri = "https://api.spotify.com/v1/users/$UserId/playlists?offset=$offset&limit=$limit"
    } else {
        $uri = "https://api.spotify.com/v1/me/playlists?offset=$offset&limit=$limit"
    }

    $playlists = @()
    if ($All) {
        do {
            $query = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
            $uri = $query.next

            foreach ($item in $query.items) {
                $playlists += $item
            }
        } while ($uri)
    } else {
        $playlists = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
        $playlists = $playlists.items
    }

    return $playlists
}