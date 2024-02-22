import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/params/base_params.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';

class UpdateProfileParams extends BaseParams{
  final String? name;
  final String? surName;
  final String? email;
  final String? date;
  final String? imageUrl;
  final String? coverImage;
  final int? gender;
  final String? phoneNumber;
   String? countryCode;

  UpdateProfileParams({
   required this.name,
   required this.imageUrl,
   required this.coverImage,
   required this.gender,
   required this.date,
   required this.email,
   required this.surName,
   required this.phoneNumber,
    this.countryCode
});

  @override
  Map<String, dynamic> toMap() {
    print(this);
    Map<String , dynamic> request = {};
    request = {
    "name": name,
    "surname": surName,
    "emailAddress": email,
    "birthdate": DateTimeHelper.getStringDateInEnglish(date),
    "imageUrl": imageUrl,
    "gender": gender,
    "cover": coverImage,
    "phoneNumber": phoneNumber,
  };
    request['countryCode'] = countryCode ?? UserSessionDataModel.countryCode;
    print('the request :');
    print(request);
    print(UserSessionDataModel.countryCode);
    return request;
  }

  @override
  String toString() {
    return 'UpdateProfileParams{name: $name, surName: $surName, email: $email, date: $date, imageUrl: $imageUrl, coverImage: $coverImage, gender: $gender, phoneNumber: $phoneNumber, countryCode: $countryCode}';
  }

  getEnglishData(String date){

  }
}