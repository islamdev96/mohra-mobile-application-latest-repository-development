import 'package:dio/dio.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/params/base_params.dart';

class GetMyRunningEventsParam extends BaseParams {
  GetMyRunningEventsParam(
      {this.latitude,
      this.longitude,
      this.ticketTypes,
      this.eventLocation,
      this.eventDate,
      this.expired,
      this.running,
      this.eventTypes,
      this.categoryIds,
      this.eventType,
      this.organizerEmail,
      this.organizerName,
      this.parentId,
      this.sorting,
      this.status,
      this.keyword,
      this.advancedSearchKeyword,
      this.categoryId,
      this.skipCount,
      this.maxResultCount,
      this.cityId,
      this.cityIds,
      this.onlyMyEvents = true,
      this.organizerId,
      CancelToken? cancelToken})
      : super(cancelToken: cancelToken);

  final String? sorting;
  final int? status;
  final String? keyword;
  final String? advancedSearchKeyword;
  final int? categoryId;
  final int? skipCount;
  final int? maxResultCount;
  final int? cityId;
  final List<int>? cityIds;
  final bool onlyMyEvents;
  final int? organizerId;
  final double? latitude;
  final double? longitude;
  final List<int>? ticketTypes;
  final int? eventLocation;
  final int? eventDate;
  final bool? expired;
  final bool? running;
  final List<int>? eventTypes;
  final List<int>? categoryIds;
  final int? eventType;
  final String? organizerEmail;
  final String? organizerName;
  final int? parentId;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> _map = {};
    _map['OnlyMyEvents'] = onlyMyEvents;
    // _map['OrganizerId'] = organizerId ?? UserSessionDataModel.userId;
    if (sorting != null) _map['Sorting'] = sorting;
     _map['status'] = 1;
    if (keyword != null) _map['keyword'] = keyword;
    if (advancedSearchKeyword != null)
      _map['advancedSearchKeyword'] = advancedSearchKeyword;
    if (categoryId != null) _map['categoryId'] = categoryId;

    if (skipCount != null) _map['skipCount'] = skipCount;
    if (maxResultCount != null) _map['maxResultCount'] = maxResultCount;
    if (cityId != null) _map['cityId'] = cityId;
    if (cityIds != null) _map['CityIds'] = cityIds!.cast();

    if (latitude != null) _map['Latitude'] = latitude;
    if (longitude != null) _map['Longitude'] = longitude;
    if (ticketTypes != null) _map['TicketTypes'] = ticketTypes!.cast();
    if (eventLocation != null) _map['EventLocation'] = eventLocation;
    if (eventDate != null) _map['EventDate'] = eventDate;
    if (expired != null) _map['Expired'] = expired;
    if (running != null) _map['Running'] = running;
    if (eventTypes != null) _map['EventTypes'] = eventTypes!.cast();
    if (categoryIds != null) _map['CategoryIds'] = categoryIds!.cast();
    if (eventType != null) _map['EventType'] = eventType;
    if (organizerEmail != null) _map['OrganizerEmail'] = organizerEmail;
    if (organizerName != null) _map['OrganizerName'] = organizerName;
    if (parentId != null) _map['ParentId'] = parentId;
    _map["IsActive"] = true;
    return _map;
  }
}
class GetEventTicketsParam extends BaseParams {
  GetEventTicketsParam(
      {this.latitude,
        this.longitude,
        this.typeIds,
        this.typeId,
        this.eventLocation,
        this.eventDate,
        this.EventId,
        this.expired,
        this.running,
        this.eventTypes,
        this.categoryIds,
        this.eventType,
        this.organizerEmail,
        this.IsScanned,
        this.organizerName,
        this.parentId,
        this.sorting,
        this.status,
        this.keyword,
        this.advancedSearchKeyword,
        this.categoryId,
        this.skipCount,
        this.maxResultCount,
        this.cityId,
        this.cityIds,
        CancelToken? cancelToken})
      : super(cancelToken: cancelToken);

  final String? sorting;
  final int? status;
  final int? EventId;
  final String? keyword;
  final String? advancedSearchKeyword;
  final int? categoryId;
  final int? skipCount;
  final int? maxResultCount;
  final int? cityId;
  final List<int>? cityIds;
  final double? latitude;
  final double? longitude;
  final List<int>? typeIds;
  final int? typeId;
  final int? eventLocation;
  final int? eventDate;
  final bool? expired;
  final bool? running;
  final bool? IsScanned;
  final List<int>? eventTypes;
  final List<int>? categoryIds;
  final int? eventType;
  final String? organizerEmail;
  final String? organizerName;
  final int? parentId;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> _map = {};
    if (sorting != null) _map['Sorting'] = sorting;
     _map['status'] = 1;
    if (keyword != null) _map['keyword'] = keyword;
    if (advancedSearchKeyword != null)
      _map['advancedSearchKeyword'] = advancedSearchKeyword;
    if (categoryId != null) _map['categoryId'] = categoryId;
    if (IsScanned != null) _map['IsScanned'] = IsScanned;

    if (skipCount != null) _map['skipCount'] = skipCount;
    if (maxResultCount != null) _map['maxResultCount'] = maxResultCount;
    if (cityId != null) _map['cityId'] = cityId;
    if (cityIds != null) _map['CityIds'] = cityIds!.cast();

    if (latitude != null) _map['Latitude'] = latitude;
    if (longitude != null) _map['Longitude'] = longitude;
    if (typeId != null) _map['Type'] = typeId;
    if (typeIds != null) _map['TypeIds'] = typeIds!.cast();
    if (eventLocation != null) _map['EventLocation'] = eventLocation;
    if (eventDate != null) _map['EventDate'] = eventDate;
    if (expired != null) _map['Expired'] = expired;
    if (running != null) _map['Running'] = running;
    if (eventTypes != null) _map['EventTypes'] = eventTypes!.cast();
    if (categoryIds != null) _map['CategoryIds'] = categoryIds!.cast();
    if (eventType != null) _map['EventType'] = eventType;
    if (organizerEmail != null) _map['OrganizerEmail'] = organizerEmail;
    if (organizerName != null) _map['OrganizerName'] = organizerName;
    if (parentId != null) _map['ParentId'] = parentId;
    if (EventId != null) _map['EventId'] = EventId;
    _map["IsActive"] = true;
    return _map;
  }
}