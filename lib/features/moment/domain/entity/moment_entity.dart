import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/comment/domain/entity/comments_entity.dart';

class MomentEntity extends BaseEntity {
  final int? totalCount;
  final List<MomentItemEntity>? items;

  MomentEntity({this.totalCount, this.items});

  @override
  List<Object?> get props => [];
}

class MomentItemEntity extends BaseEntity {
  String? friendName;
  int? commentsCount;
  List<CommentsEntity>? comments;
  List<InteractionsEntity>? interactions;
  List<VideosEntity>? videos;
  List<TagsEntity>? tags;
  int? interactionsCount;
  String? feelingIconUrl;
  final double? lat;
  final double? long;
  String? placeName;
  String? music;
  String? caption;
  List<ImagesEntity>? imageUrl;
  String? createdBy;
  final ClientEntity? client;
  int? creatorUserId;
  String? creationTime;
  int? id;
  final String? songName;
  final String? songId;
  final int? challengeId;
  final double? firstLocationLongitude;
  final double? firstLocationLatitude;
  final String? firstLocationLocationName;

  //TODO Add target location

  MomentItemEntity({
    required this.friendName,
    required this.commentsCount,
    required this.comments,
    required this.interactions,
    required this.videos,
    required this.tags,
    required this.interactionsCount,
    required this.feelingIconUrl,
    required this.placeName,
    required this.music,
    required this.caption,
    required this.imageUrl,
    required this.createdBy,
    required this.creatorUserId,
    required this.creationTime,
    required this.id,
    required this.songName,
    required this.songId,
    required this.challengeId,
    required this.lat,
    required this.long,
    required this.firstLocationLatitude,
    required this.firstLocationLocationName,
    required this.firstLocationLongitude,
    required this.client,
  });

  LatLng? get _placeLocation =>
      lat != null && long != null ? LatLng(lat!, long!) : null;

  LatLng? get _firstLocation =>
      firstLocationLatitude != null && firstLocationLongitude != null
          ? LatLng(firstLocationLatitude!, firstLocationLongitude!)
          : null;

  LatLng? get location =>
      isVerifyChallenge ? (_firstLocation ?? _placeLocation) : _placeLocation;

  bool get isVerifyChallenge => challengeId != null && challengeId != 0;

  @override
  List<Object?> get props => [];
}

class InteractionsEntity extends BaseEntity {
  String? refId;
  int? interactionType;
  int? refType;
  DateTime? creationTime;
  int? clientId;
  ClientEntity? client;
  int? id;

  InteractionsEntity(
      {this.refId,
      this.interactionType,
      this.refType,
      this.creationTime,
      this.clientId,
      this.client,
      this.id});

  @override
  List<Object?> get props => [];
}

class VideosEntity extends BaseEntity {
  String? videoUrl;
  String? description;

  VideosEntity({this.videoUrl, this.description});

  @override
  List<Object?> get props => [];
}

class ImagesEntity extends BaseEntity {
  String? imageUrl;
  String? description;

  ImagesEntity({this.imageUrl, this.description});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is ImagesEntity &&
          runtimeType == other.runtimeType &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode => super.hashCode ^ imageUrl.hashCode;

  @override
  List<Object?> get props => [];
}

class TagsEntity extends BaseEntity {
  int? clientId;
  String? clientName;

  TagsEntity({this.clientId, this.clientName});

  @override
  List<Object?> get props => [];
}

class ClientEntity extends BaseEntity {
  final String? imageUrl;
  final String? name;
  final String? phoneNumber;
  final String? emailAddress;
  final int? id;

  ClientEntity(
      {this.imageUrl, this.name, this.phoneNumber, this.emailAddress, this.id});

  @override
  List<Object?> get props => [];
}
