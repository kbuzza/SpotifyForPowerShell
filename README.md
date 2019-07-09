SpotifyForPowerShell
====================
A PowerShell module for interacting directly with the Spotify API!

**How it works:**

This module works as a wrapper for the Spotify Web API. It lets you search for songs, albums, and playlists both in and out of your library. It also allows to you connect to Spotify playback in real time. To set up the module, all you need to do is enter your Client Id and Callback into Get-SpotifyAuthorizationToken.ps1 (for help creating a Spotify application, see https://developer.spotify.com/documentation/general/guides/app-settings/#register-your-app). Lastly, adjust your page load time in Get-SpotifyAuthorizationToken (this is most easily done through personal testing). Once these values are entered, the module should be good to go!

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
- `Get-SpotifyPlaylistsPlaylist`
- `Get-SpotifyPlaylistsPlaylistPhoto`
- `Get-SpotifyPlaylistsTracks`
- `Get-SpotifyPlaylistsUserPlaylists`
- `Remove-SpotifyPlaylistsTracks`
- `Save-SpotifyPlaylistsPlaylist`
- `Save-SpotifyPlaylistsTracks`
- `Set-SpotifyPlaylistsDetails`
- `Set-SpotifyPlaylistsReorder`
<<<<<<< HEAD

Tracks API:
- `Get-SpotifyTracksAnalysis`
- `Get-SpotifyTracksFeatures`
- `Get-SpotifyTracksInfo`
=======
>>>>>>> 1d21d12539e62059fe43a484df3248965fcea273

**Change Log**
- v0.1 Initial Commit
- v0.1a Added README file
- v0.1b Updated README markdown
- v0.1c Added code folder
- v0.1d Deleting code outside folder
- v0.2 Added Library API Get functions
- v0.3 Completed initial Library API
<<<<<<< HEAD
- v0.4 Completed initial Playlist API
- v0.5 Completed initial Tracks API
=======
- v0.4 Completed initial Playlists API
>>>>>>> 1d21d12539e62059fe43a484df3248965fcea273
