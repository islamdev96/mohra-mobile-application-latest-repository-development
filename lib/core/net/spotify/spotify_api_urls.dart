class SpotifyApiUrls {
  SpotifyApiUrls._();
  /// Base Url
  static const BASE_URL = "https://api.spotify.com/v1";

  /// User related apis
  static const SAVED_ALBUMS = "/me/albums";
  static const RECENTLY_PLAYED_TRACKS = "/me/player/recently-played";
  static  updatePlaylistImage(String playlistId){
    return "/playlists/$playlistId/images" ;
  }
  static  updatePlaylistInfo(String playlistId){
    return "/playlists/$playlistId" ;
  }
}
