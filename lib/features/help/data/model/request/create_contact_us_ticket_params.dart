import 'package:starter_application/core/params/base_params.dart';

class CreateContactUsTicketParams extends BaseParams {
  String title, textTicket;
  int userId, type;

  CreateContactUsTicketParams({
    required this.type,
    required this.userId,
    required this.title,
    required this.textTicket,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'title':title,
      'textTicket':textTicket,
      'connectUsTicketTypeId':type,
      'userId':userId,
    };
  }



}
