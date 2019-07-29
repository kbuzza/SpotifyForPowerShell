function Get-SpotifySearch {
    <#
        .SYNOPSIS
            This function will return Spotify Catalog information about artists, albums,
            tracks or playlists that match a keyword string.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifySearch -Query "track:""peach""" -Type "track" -Limit 200
            C:\Users\kbuzz> Get-SpotifySearch -Query "peach" -Type "track","album","artist" -Limit 30 -Offset 10

        .PARAMETER Query
            Required. Search query keywords and optional field filters and operators. See
            https://developer.spotify.com/documentation/web-api/reference/search/search/ for
            query format guidelines.
        
        .PARAMETER Type
            Required. Comma-separated list of item types to search across. Valid types
            are "album", "artist", "playlist", and "track".
        
        .PARAMETER Limit
            Optional. Maximum number of results to return. Maximum of 50.

        .PARAMETER Offset
            Optional. Index of the first result to return. Maximum of 10,000.

        .PARAMETER IncludeExternal
            Optional. If IncludeExternal is equal to "audio", then externally hosted
            audio content is included.

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory=$true)]
        [string] $Query,

        [Parameter(Mandatory=$true)]
        [array] $Type,

        [Parameter(Mandatory = $false)]
        [ValidateRange(0,10000)]
        [int] $Offset = 0,

        [Parameter(Mandatory = $false)]
        [int] $Limit = 20,

        [Parameter(Mandatory = $false)]
        [string] $IncludeExternal,

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    if ($Type.Count -eq 0) {
        return
    }

    $Type = [string]::Join(",", $Type)

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $uri = "https://api.spotify.com/v1/search"

    $items = @()
    
    if ($Limit -gt 50) {
        $category = $Type[0] + "s"

        $uri += "?q=$Query&type=$Type&offset=0&limit=50"
        if ($IncludeExternal -eq "audio") {
            $uri += "&include_external=audio"
        }
        
        do {
            $data = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
            $uri = $data.$category.next

            foreach ($item in $data.$category.items) {
                $items += $item
            }
        } while ($uri -and $items.Count -le $Limit - 50)
    } else {
        $uri += "?q=$Query&type=$Type&offset=$Offset&limit=$Limit"
        
        if ($IncludeExternal -eq "audio") {
            $uri += "&include_external=audio"
        }

        $items = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
    }

    return $items
}
