function Save-SpotifySentencePlaylist {
    <#
        .SYNOPSIS
            This function will create a playlist that writes out a sentence using track names (if possible).

            Note: If a word cannot be found or combined with another word, a filler word will be inserted into the playlist
    
        .EXAMPLE
            C:\Users\kbuzz> Save-SpotifySentencePlaylist -Sentence "This is an example sentence"
            C:\Users\kbuzz> Save-SpotifySentencePlaylist -Sentence "Any sentence works if you do it by letter" -ByLetter

        .PARAMETER Sentence
            Required. Sentence string. Words should be separated by spaces and it should not contain punctuation.
            
            Note: Spotify does not currently provide a way to search for special characters, so avoid using special characters
            and contractions for best results.

        .Parameter ByLetter
            Optional. Switch parameter. If used, playlist will insert words by letter instead of full words.
        
        .PARAMETER Auth
            Optional. A continuation authorization token.
    #>

    param (
        [Parameter(Mandatory = $true)]
        [string] $Sentence,

        [Parameter(Mandatory = $false)]
        [switch] $ByLetter = $false,

        [Parameter(Mandatory = $false)]
        [switch] $Private,

        [Parameter(Mandatory = $false)]
        [string] $Auth
    )

    $words = $Sentence.Split()

    if ($Auth) {
        $AuthToken = $Auth
    } else {
        $AuthToken = Get-SpotifyAuthorizationToken
    }

    if ($Private) {
        $playlistId = Save-SpotifyPlaylistsPlaylist -Id (Get-SpotifyUserProfileInfo -Auth $a).id -Name $Sentence -Auth $AuthToken -Public $false
    } else {
        $playlistId = Save-SpotifyPlaylistsPlaylist -Id (Get-SpotifyUserProfileInfo -Auth $a).id -Name $Sentence -Auth $AuthToken -Public $true
    }
    
    $playlistId = $playlistId.id

    if ($ByLetter) {
        $songPosition = 0
        $slash = '2KjezXmSbeXFNBkulpTPTa'

        foreach ($word in $words) {
            for ($i = 0; $i -lt ($word).Length; $i++) {            
                $track = Get-SpotifySentenceAlphabetMatch -Letter $word[$i]

                Save-SpotifyPlaylistsTracks -Id $playlistId -Tracks $track -Position $songPosition -Auth $AuthToken

                $songPosition++
            }
            if ($words.IndexOf($word) -ne $words.Count - 1) {
                Save-SpotifyPlaylistsTracks -Id $playlistId -Tracks $slash -Position $songPosition -Auth $AuthToken

                $songPosition++
            }
        }
    } else {
        $lastTrack
        $songPosition = 0

        foreach ($word in $words) {
            $id = Get-SpotifySentenceTrackMatch -Phrase $word -Auth $AuthToken
            if ($id) {
                Save-SpotifyPlaylistsTracks -Id $playlistId -Tracks $id -Position $songPosition -Auth $AuthToken

                $songPosition++
                $lastTrack = $id
            } else {
                if ($words.IndexOf($word) -ne 0) {
                    $phrase = $words[$words.IndexOf($word) - 1] + " " + $words[$words.IndexOf($word)]

                    $id = Get-SpotifySentenceTrackMatch -Phrase $phrase -Auth $AuthToken

                    if ($id) {
                        $songPosition--

                        Remove-SpotifyPlaylistsTracks -Id $playlistId -Tracks $lastTrack -Auth $AuthToken
                        Save-SpotifyPlaylistsTracks -Id $playlistId -Tracks $id -Position $songPosition -Auth $AuthToken

                        $songPosition++
                    } else {
                        Save-SpotifyPlaylistsTracks -Id $playlistId -Tracks "7n8HTBeizZPBpRHWq8ZQDT" -Position $songPosition -Auth $AuthToken
                        
                        $songPosition++
                    }
                } else {
                    Save-SpotifyPlaylistsTracks -Id $playlistId -Tracks "7n8HTBeizZPBpRHWq8ZQDT" -Position $songPosition -Auth $AuthToken
                    
                    $songPosition++
                }
            }
        }
    }

    return $playlistId
}