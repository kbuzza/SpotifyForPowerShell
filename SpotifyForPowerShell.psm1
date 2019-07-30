$Global:ClientId     = "19ea14240fc04dae8f57243ed42ce785" # client id from spotify application
$Global:RedirectUri  = "http://localhost:3000/callback"   # client redirect uri from spotify application
$Global:PageLoadTime = 15                                 # minimum time it takes to load form (may need to test this on your internet)
                                                          # (Recommended)

# Authorization
Import-Module .\AuthorizationAPI\Get-SpotifyAuthorizationToken.ps1

# Library API
Import-Module .\LibraryAPI\Get-SpotifyLibraryTracks.ps1
Import-Module .\LibraryAPI\Get-SpotifyLibraryAlbums.ps1
Import-Module .\LibraryAPI\Get-SpotifyLibraryTracksContains.ps1
Import-Module .\LibraryAPI\Get-SpotifyLibraryAlbumsContains.ps1
Import-Module .\LibraryAPI\Save-SpotifyLibraryTracks.ps1
Import-Module .\LibraryAPI\Save-SpotifyLibraryAlbums.ps1
Import-Module .\LibraryAPI\Remove-SpotifyLibraryTracks.ps1
Import-Module .\LibraryAPI\Remove-SpotifyLibraryAlbums.ps1

# Playlist API
Import-Module .\PlaylistsAPI\Get-SpotifyPlaylistsInfo.ps1
Import-Module .\PlaylistsAPI\Get-SpotifyPlaylistsPlaylistPhoto.ps1
Import-Module .\PlaylistsAPI\Get-SpotifyPlaylistsTracks.ps1
Import-Module .\PlaylistsAPI\Get-SpotifyPlaylistsUserPlaylists.ps1
Import-Module .\PlaylistsAPI\Remove-SpotifyPlaylistsTracks.ps1
Import-Module .\PlaylistsAPI\Save-SpotifyPlaylistsPlaylist.ps1
Import-Module .\PlaylistsAPI\Save-SpotifyPlaylistsTracks.ps1
Import-Module .\PlaylistsAPI\Set-SpotifyPlaylistsDetails.ps1
Import-Module .\PlaylistsAPI\Set-SpotifyPlaylistsReorder.ps1

# Tracks API
Import-Module .\TracksAPI\Get-SpotifyTracksAnalysis.ps1
Import-Module .\TracksAPI\Get-SpotifyTracksFeatures.ps1
Import-Module .\TracksAPI\Get-SpotifyTracksInfo.ps1

# Albums API
Import-Module .\AlbumsAPI\Get-SpotifyAlbumsInfo.ps1
Import-Module .\AlbumsAPI\Get-SpotifyAlbumsTracks.ps1

# Artists API
Import-Module .\ArtistsAPI\Get-SpotifyArtistsAlbums.ps1
Import-Module .\ArtistsAPI\Get-SpotifyArtistsInfo.ps1
Import-Module .\ArtistsAPI\Get-SpotifyArtistsRelatedArtists.ps1
Import-Module .\ArtistsAPI\Get-SpotifyArtistsTopTracks.ps1

# Personalization API
Import-Module .\PersonalizationAPI\Get-SpotifyPersonalizationTop.ps1

# User API
Import-Module .\UserAPI\Get-SpotifyUserProfileInfo.ps1
Import-Module .\UserAPI\Get-SpotifyUserProfilePublicInfo.ps1

# Search API
Import-Module .\SearchAPI\Get-SpotifySearch.ps1

# Browse API
Import-Module .\BrowseAPI\Get-SpotifyBrowseCategories.ps1
Import-Module .\BrowseAPI\Get-SpotifyBrowseCategoryInfo.ps1
Import-Module .\BrowseAPI\Get-SpotifyBrowseCategoryPlaylists.ps1
Import-Module .\BrowseAPI\Get-SpotifyBrowseFeaturedPlaylists.ps1
Import-Module .\BrowseAPI\Get-SpotifyBrowseNewReleases.ps1
Import-Module .\BrowseAPI\Get-SpotifyBrowseRecommendationGenres.ps1
Import-Module .\BrowseAPI\Get-SpotifyBrowseRecommendations.ps1

# Follow API
Import-Module .\FollowAPI\Get-SpotifyFollowFollowingState.ps1
Import-Module .\FollowAPI\Get-SpotifyFollowUserFollowingArtists.ps1
Import-Module .\FollowAPI\Invoke-SpotifyFollowPerson.ps1
Import-Module .\FollowAPI\Invoke-SpotifyFollowPlaylist.ps1
Import-Module .\FollowAPI\Remove-SpotifyFollowPerson.ps1
Import-Module .\FollowAPI\Remove-SpotifyFollowPlaylist.ps1

# Player API
Import-Module .\PlayerAPI\Get-SpotifyPlayerCurrentPlayback.ps1
Import-Module .\PlayerAPI\Get-SpotifyPlayerCurrentTrack.ps1
Import-Module .\PlayerAPI\Get-SpotifyPlayerDevices.ps1
Import-Module .\PlayerAPI\Get-SpotifyPlayerRecentlyPlayed.ps1
Import-Module .\PlayerAPI\Invoke-SpotifyPlayerSkipNext.ps1
Import-Module .\PlayerAPI\Invoke-SpotifyPlayerSkipPrevious.ps1
Import-Module .\PlayerAPI\Invoke-SpotifyPlayerTransferPlayback.ps1
Import-Module .\PlayerAPI\Set-SpotifyPlayerPause.ps1
Import-Module .\PlayerAPI\Set-SpotifyPlayerPlay.ps1
Import-Module .\PlayerAPI\Set-SpotifyPlayerPosition.ps1
Import-Module .\PlayerAPI\Set-SpotifyPlayerRepeat.ps1
Import-Module .\PlayerAPI\Set-SpotifyPlayerShuffle.ps1
Import-Module .\PlayerAPI\Set-SpotifyPlayerVolume.ps1

# Playlist Sentence Creator Project
Import-Module .\SampleProjects\PlaylistSentenceCreator\Save-SpotifySentencePlaylist.ps1
Import-Module .\SampleProjects\PlaylistSentenceCreator\Get-SpotifySentenceTrackMatch.ps1
Import-Module .\SampleProjects\PlaylistSentenceCreator\Get-SpotifySentenceAlphabetMatch.ps1