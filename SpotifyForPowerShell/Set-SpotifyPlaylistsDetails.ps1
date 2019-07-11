function Set-SpotifyPlaylistsDetails {
    <#
        .SYNOPSIS
            This function allows the user to set the details of a playlist.
    
        .EXAMPLE
            C:\Users\kbuzz> Set-SpotifyPlaylistsDetails -Id "5mFbFhHahoLBsF7FUFTb4l" -Name "New Name" -Collaborative $true
            
        .PARAMETER Id
            Required. String representation of playlist id.
        
        .PARAMETER Name
            Optional. New name for the playlist.
        
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
        [Parameter(Mandatory = $true)] [string] $Id,

        [string] $Name,

        [bool] $Public,

        [bool] $Collaborative,

        [string] $Description,

        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/playlists/$Id"

    
    $body = "{"
    if ($Name) {
        $body += ",""name"":""$Name"""
    }
    if ($Public) {
        $body += ",""public"":""$Public"""
    }
    if ($Collaborative) {
        $body += ",""collaborative"":""$Collaborative"""
    }
    if ($Description) {
        $body += ",""description"":""$Description"""
    }    
    $body += "}"
    
    if ($body.Contains(",")) {
        $body = "{" + $body.Substring(2)
    }
        
    $playlist = Invoke-RestMethod -Uri $uri -Method Put -Headers @{Authorization="Bearer $AuthToken"} -Body $body
    return $playlist
}