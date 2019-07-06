SpotifyForPowerShell
====================
A PowerShell module for interacting directly with the Spotify API!

**How it works:**

This module works as a wrapper for the Spotify Web API. It lets you search for songs, albums, and playlists both in and out of your library. It also allows to you connect to Spotify playback in real time. To set up the module, all you need to do is enter your Client Id and Callback (for help creating a Spotify application, see ![here])(https://developer.spotify.com/documentation/general/guides/app-settings/#register-your-app) into Get-SpotifyAuthorizationToken.ps1. Lastly, adjust your page load time in Get-SpotifyAuthorizationToken (this is most easily done through personal testing). Once these values are entered, the module should be good to go!

**Current function implementations:**
-`Get-SpotifyAuthorizationToken`
-`Get-SpotifySavedTracks`