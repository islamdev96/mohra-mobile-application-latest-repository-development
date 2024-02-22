import 'package:starter_application/core/params/base_params.dart';

class CreateEditPostParam extends BaseParams {
  final String? caption;
  final String? feelingIconUrl;
  final String? placeName;
  final String? songName;
  final String? songId;
  final List<VideoParam>? videos;
  final List<int>? tags;
  final List<ImageParam>? imageUrl;
  final int? challengeId;
  final double? lat;
  final double? long;

  /// For edit post only
  final int? id;

  CreateEditPostParam({
    this.caption,
    this.feelingIconUrl,
    this.placeName,
    this.videos,
    this.tags,
    this.imageUrl,
    this.songName,
    this.songId,
    this.id,
    this.challengeId,
    this.lat,
    this.long,
  });

  Map<String, dynamic> toMap() {
    return {
      if (caption != null) 'caption': caption,
      if (feelingIconUrl != null) 'feelingIconUrl': feelingIconUrl,
      if (lat != null) 'lat': lat,
      if (long != null) 'long': long,
      if (placeName != null) 'placeName': placeName,
      if (songName != null) 'songName': songName,
      if (songId != null) 'songId': songId,
      if (videos != null) 'videos': videos!.map((e) => e.toMap()).toList(),
      if (tags != null) 'tags': tags,
      if (imageUrl != null) 'images': imageUrl!.map((e) => e.toMap()).toList(),
      if (id != null) 'id': id,
      if (challengeId != null) 'challengeId': challengeId,
    };
  }
}

class VideoParam extends BaseParams {
  final String videoUrl;
  final String? videoPath;
  final String? description;

  VideoParam({
    required this.videoUrl,
    this.description,
     this.videoPath,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoParam &&
          runtimeType == other.runtimeType &&
          videoUrl == other.videoUrl;

  @override
  int get hashCode => videoUrl.hashCode;

  @override
  Map<String, dynamic> toMap() => {
        "videoUrl": videoUrl,
        if (description != null) "description": description,
      };
}

class ImageParam extends BaseParams {
  final String imageUrl;
  final String? imagePath;
  final String? description;

  ImageParam({
    required this.imageUrl,
    this.description,
     this.imagePath,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageParam &&
          runtimeType == other.runtimeType &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode => imageUrl.hashCode;

  @override
  Map<String, dynamic> toMap() => {
        "imageUrl": imageUrl,
        if (description != null) "description": description,
      };
}
