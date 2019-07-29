function Get-SpotifySentenceTrackMatch {
    <#
        .SYNOPSIS
            This function will find a track name matching a string (if possible) and return its id.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifySentenceTrackMatch "kyle"

        .PARAMETER Phrase
            Required. 1 or more words in a single string to find a matching song for.
        
        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)]
        [string] $Phrase,

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }

    $count = 1

    $uri = "https://api.spotify.com/v1/search"
    $uri += "?q=track:""$Phrase""&type=track&offset=0&limit=50"

    do {
        $data = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization="Bearer $AuthToken"}
        $uri = $data.tracks.next
        
        foreach ($item in $data.tracks.items) {
            if (($item.name).ToLower() -eq $Phrase.toLower()) {
                return $item.id
            }
            $count++
        }
    } while ($uri -and $count -le 10000)
    
    return $null
}