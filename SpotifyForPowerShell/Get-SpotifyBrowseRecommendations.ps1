function Get-SpotifyBrowseRecommendations {
    <#
        .SYNOPSIS
            This function will return a list of recommended tracks based on different types of input seeds.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyBrowseRecommendations -Auth $Auth -SeedGenres "sad","hip-hop" -Limit 10 -Minlist "tempo",180

        .PARAMETER SeedArtists
            Required. Comma separated list of Spotify IDs for seed artists.

        .PARAMETER SeedGenres
            Required. Comma separated list of seed genres.

        .PARAMETER SeedTracks
            Required. Comma separated list of Spotify IDs for seed tracks.
            
        NOTE: A maximum of 5 seeds can be provided combined from the three seed types.

        .PARAMETER Limit
            Optional. Must be between 1 and 100. Represents the number of playlists to return.

        .PARAMETER MinList
            Optional. A comma separated list of minimum tunable track attributes and corresponding values.
            Example: "instrumentalness", 0.35, "tempo", 140

        .PARAMETER MaxList
            Optional. A comma separated list of maximum tunable track attributes and corresponding values.
            Example: "instrumentalness", 0.8, "tempo", 200

        .PARAMETER TargetList
            Optional. A comma separated list of target tunable track attributes and corresponding values.
            Example: "instrumentalness", 0.5, "tempo", 175

        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $false)]
        [array] $SeedArtists = @(),

        [Parameter(Mandatory = $false)]
        [array] $SeedGenres = @(),

        [Parameter(Mandatory = $false)]
        [array] $SeedTracks = @(),

        [Parameter(Mandatory = $false)]
        [ValidateRange(1,100)] [int] $Limit = 20,

        [Parameter(Mandatory = $false)]
        [array] $MinList = @(),

        [Parameter(Mandatory = $false)]
        [array] $MaxList = @(),

        [Parameter(Mandatory = $false)]
        [array] $TargetList = @(),

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }
        
    $uri = "https://api.spotify.com/v1/recommendations?limit=$Limit"  

    $seedCount = $SeedArtists.Count + $SeedGenres.Count + $SeedTracks.Count
    if (($seedCount -eq 0) -or ($seedCount -gt 5)) {
        return $null
    } elseif ($MinList.Count % 2 -eq 1) {
        return $null
    } elseif ($MaxList.Count % 2 -eq 1) {
        return $null
    } elseif ($TargetList.Count % 2 -eq 1) {
        return $null
    }

    if ($SeedArtists.Count -gt 0) {
        $uri += "&seed_artists="
        foreach ($seed in $SeedArtists) {
            $uri += "$seed,"
        }
    }
    $uri = $uri.Substring(0, $uri.Length - 1)

    if ($SeedGenres.Count -gt 0) {
        $uri += "&seed_genres="
        foreach ($seed in $SeedGenres) {
            $uri += "$seed,"
        }
    }
    $uri = $uri.Substring(0, $uri.Length - 1)

    if ($SeedTracks.Count -gt 0) {
        $uri += "&seed_tracks="
        foreach ($seed in $SeedArtists) {
            $uri += "$seed,"
        }
    }
    $uri = $uri.Substring(0, $uri.Length - 1)
 
    if ($MinList.Count -gt 0) {
        for ($i = 0; $i -lt $MinList.Count; $i+=2) {
            $uri += "&min_" + $MinList[$i] + "=" + $MinList[$i + 1]
        }
    }

    if ($MaxList.Count -gt 0) {
        for ($i = 0; $i -lt $MaxList.Count; $i+=2) {
            $uri += "&min_" + $MaxList[$i] + "=" + $MaxList[$i + 1]
        }
    }

    if ($TargetList.Count -gt 0) {
        for ($i = 0; $i -lt $TargetList.Count; $i+=2) {
            $uri += "&min_" + $TargetList[$i] + "=" + $TargetList[$i + 1]
        }
    }

    $query = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}

    return $query
}