function Save-SpotifyPlaylistsPlaylist {
    <#
        .SYNOPSIS
            This function allows the user to create a new playlist.
    
        .EXAMPLE
            C:\Users\kbuzz> Save-SpotifyPlaylistsPlaylist -Id "yaboybuzza" -Name "New Name" -Collaborative $true
            
        .PARAMETER Id
            Required. String representation of a user id.
        
        .PARAMETER Name
            Required. New name for the playlist.
        
        .PARAMETER Public
            Optional. If true the playlist will be public, if false it will be private.

        .PARAMETER Collaborative
            Optional. If true, the playlist will become collaborative. Non-public playlists
            cannot be set to true.
    
        .PARAMETER Description
            Optional. New description for the playlist.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)]
        [string] $Id,

        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string] $Name,

        [Parameter(Mandatory = $false)]
        [bool] $Public = $true,

        [Parameter(Mandatory = $false)]
        [bool] $Collaborative = $false,

        [Parameter(Mandatory = $false)]
        [string] $Description = "",

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/users/$Id/playlists"

    
    $body = "{"
    $body += """name"":""$Name"""
    $body += ",""public"":""$Public"""
    $body += ",""collaborative"":""$Collaborative"""

    if ($Description) {
        $body += ",""description"":""$Description"""
    }

    $body += "}"
        
    $playlist = Invoke-RestMethod -Uri $uri -Method Post -Headers @{Authorization="Bearer $AuthToken"} -Body $body
    
    return $playlist
}