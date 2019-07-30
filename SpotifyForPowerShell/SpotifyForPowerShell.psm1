$Global:ClientId     = "19ea14240fc04dae8f57243ed42ce785" # client id from spotify application
$Global:RedirectUri  = "http://localhost:3000/callback"   # client redirect uri from spotify application
$Global:PageLoadTime = 5                                  # minimum time it takes to load form (may need to test this on your internet)

# Authorization
Import-Module .\SpotifyForPowerShell\Authorization\Get-SpotifyAuthorizationToken.ps1

# Library API
Import-Module .\SpotifyForPowerShell\Library\Get-SpotifyLibraryTracks.ps1
Import-Module .\SpotifyForPowerShell\Library\Get-SpotifyLibraryAlbums.ps1
Import-Module .\SpotifyForPowerShell\Library\Get-SpotifyLibraryTracksContains.ps1
Import-Module .\SpotifyForPowerShell\Library\Get-SpotifyLibraryAlbumsContains.ps1
Import-Module .\SpotifyForPowerShell\Library\Save-SpotifyLibraryTracks.ps1
Import-Module .\SpotifyForPowerShell\Library\Save-SpotifyLibraryAlbums.ps1
Import-Module .\SpotifyForPowerShell\Library\Remove-SpotifyLibraryTracks.ps1
Import-Module .\SpotifyForPowerShell\Library\Remove-SpotifyLibraryAlbums.ps1

# Playlist API
Import-Module .\SpotifyForPowerShell\Playlists\Get-SpotifyPlaylistsInfo.ps1
Import-Module .\SpotifyForPowerShell\Playlists\Get-SpotifyPlaylistsPlaylistPhoto.ps1
Import-Module .\SpotifyForPowerShell\Playlists\Get-SpotifyPlaylistsTracks.ps1
Import-Module .\SpotifyForPowerShell\Playlists\Get-SpotifyPlaylistsUserPlaylists.ps1
Import-Module .\SpotifyForPowerShell\Playlists\Remove-SpotifyPlaylistsTracks.ps1
Import-Module .\SpotifyForPowerShell\Playlists\Save-SpotifyPlaylistsPlaylist.ps1
Import-Module .\SpotifyForPowerShell\Playlists\Save-SpotifyPlaylistsTracks.ps1
Import-Module .\SpotifyForPowerShell\Playlists\Set-SpotifyPlaylistsDetails.ps1
Import-Module .\SpotifyForPowerShell\Playlists\Set-SpotifyPlaylistsReorder.ps1

# Tracks API
Import-Module .\SpotifyForPowerShell\Tracks\Get-SpotifyTracksAnalysis.ps1
Import-Module .\SpotifyForPowerShell\Tracks\Get-SpotifyTracksFeatures.ps1
Import-Module .\SpotifyForPowerShell\Tracks\Get-SpotifyTracksInfo.ps1

# Albums API
Import-Module .\SpotifyForPowerShell\Albums\Get-SpotifyAlbumsInfo.ps1
Import-Module .\SpotifyForPowerShell\Albums\Get-SpotifyAlbumsTracks.ps1

# Artists API
Import-Module .\SpotifyForPowerShell\Artists\Get-SpotifyArtistsAlbums.ps1
Import-Module .\SpotifyForPowerShell\Artists\Get-SpotifyArtistsInfo.ps1
Import-Module .\SpotifyForPowerShell\Artists\Get-SpotifyArtistsRelatedArtists.ps1
Import-Module .\SpotifyForPowerShell\Artists\Get-SpotifyArtistsTopTracks.ps1

# Personalization API
Import-Module .\SpotifyForPowerShell\Personalization\Get-SpotifyPersonalizationTop.ps1

# User API
Import-Module .\SpotifyForPowerShell\User\Get-SpotifyUserProfileInfo.ps1
Import-Module .\SpotifyForPowerShell\User\Get-SpotifyUserProfilePublicInfo.ps1

# Search API
Import-Module .\SpotifyForPowerShell\Search\Get-SpotifySearch.ps1

# Browse API
Import-Module .\SpotifyForPowerShell\Browse\Get-SpotifyBrowseCategories.ps1
Import-Module .\SpotifyForPowerShell\Browse\Get-SpotifyBrowseCategoryInfo.ps1
Import-Module .\SpotifyForPowerShell\Browse\Get-SpotifyBrowseCategoryPlaylists.ps1
Import-Module .\SpotifyForPowerShell\Browse\Get-SpotifyBrowseFeaturedPlaylists.ps1
Import-Module .\SpotifyForPowerShell\Browse\Get-SpotifyBrowseNewReleases.ps1
Import-Module .\SpotifyForPowerShell\Browse\Get-SpotifyBrowseRecommendationGenres.ps1
Import-Module .\SpotifyForPowerShell\Browse\Get-SpotifyBrowseRecommendations.ps1

# Follow API
Import-Module .\SpotifyForPowerShell\Follow\Get-SpotifyFollowFollowingState.ps1
Import-Module .\SpotifyForPowerShell\Follow\Get-SpotifyFollowUserFollowingArtists.ps1
Import-Module .\SpotifyForPowerShell\Follow\Invoke-SpotifyFollowPerson.ps1
Import-Module .\SpotifyForPowerShell\Follow\Invoke-SpotifyFollowPlaylist.ps1
Import-Module .\SpotifyForPowerShell\Follow\Remove-SpotifyFollowPerson.ps1
Import-Module .\SpotifyForPowerShell\Follow\Remove-SpotifyFollowPlaylist.ps1

# Player API
Import-Module .\SpotifyForPowerShell\Player\Get-SpotifyPlayerCurrentPlayback.ps1
Import-Module .\SpotifyForPowerShell\Player\Get-SpotifyPlayerCurrentTrack.ps1
Import-Module .\SpotifyForPowerShell\Player\Get-SpotifyPlayerDevices.ps1
Import-Module .\SpotifyForPowerShell\Player\Get-SpotifyPlayerRecentlyPlayed.ps1
Import-Module .\SpotifyForPowerShell\Player\Invoke-SpotifyPlayerSkipNext.ps1
Import-Module .\SpotifyForPowerShell\Player\Invoke-SpotifyPlayerSkipPrevious.ps1
Import-Module .\SpotifyForPowerShell\Player\Invoke-SpotifyPlayerTransferPlayback.ps1
Import-Module .\SpotifyForPowerShell\Player\Set-SpotifyPlayerPause.ps1
Import-Module .\SpotifyForPowerShell\Player\Set-SpotifyPlayerPlay.ps1
Import-Module .\SpotifyForPowerShell\Player\Set-SpotifyPlayerPosition.ps1
Import-Module .\SpotifyForPowerShell\Player\Set-SpotifyPlayerRepeat.ps1
Import-Module .\SpotifyForPowerShell\Player\Set-SpotifyPlayerShuffle.ps1
Import-Module .\SpotifyForPowerShell\Player\Set-SpotifyPlayerVolume.ps1

# Playlist Sentence Creator Project
Import-Module .\SpotifyForPowerShell\PlaylistSentenceCreator\Save-SpotifySentencePlaylist.ps1
Import-Module .\SpotifyForPowerShell\PlaylistSentenceCreator\Get-SpotifySentenceTrackMatch.ps1
Import-Module .\SpotifyForPowerShell\PlaylistSentenceCreator\Get-SpotifySentenceAlphabetMatch.ps1