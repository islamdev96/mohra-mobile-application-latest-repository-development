import 'package:flutter/cupertino.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/features/account/domain/entity/city_entity.dart';
import 'package:starter_application/features/religion/presentation/logic/quran_classes.dart';
import 'package:starter_application/features/shop/data/model/response/get_taxfee_model.dart';

class SessionData extends ChangeNotifier {
  List<Surah> surahs = [];

  //.test Temps for testing
  /// User info
  int? _userId;
  String? _firstName;
  String? _lastName;
  String? phoneNumber;
  List<CityEntity> cities = [];
  int? dayAdded;
  GetSettingModel? getSettingModel;

  /// Auth token
  String? _token;
  String? token;

  Future<void> storFullName() async {
    if (_firstName != null && _lastName != null) {
      await storeName([_firstName!, _lastName!]);
    }
  }

  Future<void> clear() async {
    _firstName = null;
    _lastName = null;
    _token = null;
    _userId = null;
    await clearName();
    await clearUserId();
    await cleartoken();
  }

  /// Get session data from shared preference
  Future<void> getSessionDataFromSP() async {
    /// get full name
    final name = await getName();
    if (name != null) {
      _firstName = name[0];
      _lastName = name[1];
    }

    /// get token
    final token = await getToken();
    if (token != null) {
      _token = token;
    }

    /// get userId
    _userId = await getUserId();
  }

  /// Getters and Setters
  String? get firstName => this._firstName;
  get lastName => this._lastName;

  set firstName(String? value) {
    this._firstName = value;
  }

  set lastName(value) {
    this._lastName = value;
  }

  bool get hasName => _firstName != null && _lastName != null;
  bool get hasToken => _token != null;
  int? get userId => _userId;
}
