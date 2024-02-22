import 'package:starter_application/core/params/base_params.dart';

class GetEventTicketRequest extends BaseParams {
  GetEventTicketRequest({
    this.id,
  });

  final int? id;

  factory GetEventTicketRequest.fromMap(Map<String, dynamic> json) =>
      GetEventTicketRequest(
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
      };
}
