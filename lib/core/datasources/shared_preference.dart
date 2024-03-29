import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  static SpUtil? _instance;

  static Future<SpUtil> get instance async {
    return await getInstance();
  }

  static SharedPreferences? _spf;

  SpUtil._();

  Future _init() async {
    _spf = await SharedPreferences.getInstance();
  }

  static Future<SpUtil> getInstance() async {
    if (_instance == null) {
      _instance = new SpUtil._();
      await _instance!._init();
    }
    return _instance!;
  }

  static bool _beforeCheck() {
    if (_spf == null) {
      return true;
    }
    return false;
  }

  bool hasKey(String key) {
    Set keys = getKeys()!;
    return keys.contains(key);
  }

  Set<String>? getKeys() {
    if (_beforeCheck()) return null;
    return _spf!.getKeys();
  }

  get(String key) {
    if (_beforeCheck()) return null;
    return _spf!.get(key);
  }

  String? getString(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getString(key);
  }

  Future<bool>? putString(String key, String value) {
    if (_beforeCheck()) return null;
    return _spf!.setString(key, value);
  }

  bool? getBool(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getBool(key);
  }

  Future<bool>? putBool(String key, bool value) {
    if (_beforeCheck()) return null;
    return _spf!.setBool(key, value);
  }

  int? getInt(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getInt(key);
  }

  Future<bool>? putInt(String key, int value) {
    if (_beforeCheck()) return null;
    return _spf!.setInt(key, value);
  }

  double? getDouble(String key) {
    if (_beforeCheck()) return null;
    return _spf!.getDouble(key);
  }

  Future<bool>? putDouble(String key, double value) {
    if (_beforeCheck()) return null;
    return _spf!.setDouble(key, value);
  }

  List<String>? getStringList(String key) {
    return _spf!.getStringList(key);
  }

  Future<bool>? putStringList(String key, List<String> value) {
    if (_beforeCheck()) return null;
    return _spf!.setStringList(key, value);
  }

  Future<bool>? updateStringList(String key, String value)async {
    List<String>? mOriginaList = await getStringList(key) ?? [];
    if(!mOriginaList.contains(value))
      mOriginaList.add(value);
    else
      mOriginaList.remove(value);
    return _spf!.setStringList(key, mOriginaList);
  }

   bool foundStringInList(String key,String value) {
   return (getStringList(key) ?? []).contains(value);
  }

    dynamic getDynamic(String key) {
      if (_beforeCheck()) return null;
      return _spf!.get(key);
    }

    Future<bool>? remove(String key) {
      if (_beforeCheck()) return null;
      return _spf!.remove(key);
    }

    Future<bool>? clear() {
      if (_beforeCheck()) return null;
      return _spf!.clear();
    }
  }

