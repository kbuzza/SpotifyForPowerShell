SpotifyForPowerShell
====================
A PowerShell module for interacting directly with the Spotify API!

**How it works:**

This module works as a wrapper for the Spotify Web API. It contains a PowerShell function corresponding to each listed Spotify API commands. To set up the module, all you need to do is enter your Client Id and Callback into Get-SpotifyAuthorizationToken.ps1 (for help creating a Spotify application, see https://developer.spotify.com/documentation/general/guides/app-settings/#register-your-app). Lastly, adjust your page load time in Get-SpotifyAuthorizationToken (this is most easily done through personal testing; I use 5 seconds).

**Installation Instructions:**
1. Run the following command in a Git shell or on the PowerShell command line: `git clone https://github.com/kbuzza/SpotifyForPowerShell.git`
2. Add your personal ClientId, RedirectUri, and PageLoadTime to SpotifyForPowerShell.psm1
3. Import the module using: `Import-Module .\SpotifyForPowerShell.psd1`

**Current function implementations:**

Authorization:
- `Get-SpotifyAuthorizationToken`

Library API:
- `Get-SpotifyLibraryTracks`
- `Get-SpotifyLibraryAlbums`
- `Get-SpotifyLibraryTracksContains`
- `Get-SpotifyLibraryAlbumsContains`
- `Save-SpotifyLibraryTracks`
- `Save-SpotifyLibraryAlbums`
- `Remove-SpotifyLibraryTracks`
- `Remove-SpotifyLibraryAlbums`

Playlists API:
- `Get-SpotifyPlaylistsInfo`
- `Get-SpotifyPlaylistsPlaylistPhoto`
- `Get-SpotifyPlaylistsTracks`
- `Get-SpotifyPlaylistsUserPlaylists`
- `Remove-SpotifyPlaylistsTracks`
- `Save-SpotifyPlaylistsPlaylist`
- `Save-SpotifyPlaylistsTracks`
- `Set-SpotifyPlaylistsDetails`
- `Set-SpotifyPlaylistsReorder`

Tracks API:
- `Get-SpotifyTracksAnalysis`
- `Get-SpotifyTracksFeatures`
- `Get-SpotifyTracksInfo`

Albums API:
- `Get-SpotifyAlbumsInfo`
- `Get-SpotifyAlbumsTracks`

Artists API:
- `Get-SpotifyArtistsAlbums`
- `Get-SpotifyArtistsInfo`
- `Get-SpotifyArtistsRelatedArtists`
- `Get-SpotifyArtistsTopTracks`

Personalization API:
- `Get-SpotifyPersonalizationTop`

User Profile API:
- `Get-SpotifyUserProfileInfo`
- `Get-SpotifyUserProfilePublicInfo`

Search API:
- `Get-SpotifySearch`

Browse API:
- `Get-SpotifyBrowseCategories`
- `Get-SpotifyBrowseCategoryInfo`
- `Get-SpotifyBrowseCategoryPlaylists`
- `Get-SpotifyBrowseFeaturedPlaylists`
- `Get-SpotifyBrowseNewReleases`
- `Get-SpotifyBrowseRecommendationGenres`
- `Get-SpotifyBrowseRecommendations`

Follow API:
- `Get-SpotifyFollowFollowingState`
- `Get-SpotifyFollowUserFollowingArtists`
- `Invoke-SpotifyFollowPerson`
- `Invoke-SpotifyFollowPlaylist`
- `Remove-SpotifyFollowPerson`
- `Remove-SpotifyFollowPlaylist`

Player API:
- `Get-SpotifyPlayerCurrentPlayback`
- `Get-SpotifyPlayerCurrentTrack`
- `Get-SpotifyPlayerDevices`
- `Get-SpotifyPlayerRecentlyPlayed`
- `Invoke-SpotifyPlayerSkipNext`
- `Invoke-SpotifyPlayerSkipPrevious`
- `Invoke-SpotifyPlayerTransferPlayback`
- `Set-SpotifyPlayerPause`
- `Set-SpotifyPlayerPlay`
- `Set-SpotifyPlayerPosition`
- `Set-SpotifyPlayerRepeat`
- `Set-SpotifyPlayerShuffle`
- `Set-SpotifyPlayerVolume`

**Sample Projects:**

Playlist Sentence Creator:
- `Save-SpotifySentencePlaylist`
- `Get-SpotifySentenceTrackMatch`
- `Get-SpotifySentenceAlphabetMatch`

Musical Chairs:
- `Invoke-SpotifyMusicalChairs`

**Change Log:**
- v1.2 Added sample project - Musical Chairs (Current)
- v1.1a Updated folder hierarchy
- v1.1 Added API folders and implemented manifest module
- v1.0 Initial Release
- v0.11 Completed initial Player API
- v0.10 Completed intial Browse/Follow APIs
- v0.9 Added sample project - Playlist Sentence Creator
- v0.8a Added "Auth" Continuation Parameter
- v0.8 Completed initial Search API
- v0.7 Completed initial Personalization/User Profile APIs
- v0.6 Completed initial Albums/Artists APIs
- v0.5 Completed initial Tracks API
- v0.4 Completed initial Playlist API
- v0.3 Completed initial Library API
- v0.2 Added Library API Get functions
- v0.1 Initial Commit