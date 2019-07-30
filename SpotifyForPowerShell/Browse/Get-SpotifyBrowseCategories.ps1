function Get-SpotifyBrowseCategories {
    <#
        .SYNOPSIS
            This function will return a list of categories used to tag items in Spotify.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyBrowseCategories -Auth $a -Offset 3 -Limit 10
            
        .PARAMETER Offset
            Optional. Must be between 0 and 10000. Represents the starting point of the search.

        .PARAMETER Limit
            Optional. Must be between 1 and 50. Represents the number of categories to return.

        .PARAMETER All
            Optional. When this parameter is used, every category will be returned.

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
        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
    
    $categories = @()
    
    if ($All) {
        $uri = "https://api.spotify.com/v1/browse/categories?offset=0&limit=50"

        do {
            $query = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
            $uri = $query.categories.next

            foreach ($item in $query.categories.items) {
                $categories += $item
            }
        } while ($uri)
    } else {
        $uri = "https://api.spotify.com/v1/browse/categories?offset=$Offset&limit=$Limit"
        
        $categories = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
        $categories = $categories.categories.items
    }

    return $categories
}