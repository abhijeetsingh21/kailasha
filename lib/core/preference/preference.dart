
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instance = Preferences._internal();
  late SharedPreferences _sharedPreferences;


  Preferences._internal();

  factory Preferences() => _instance;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    // await _handleFirstInstall();
  }


  Future<void> setToken(String key, String token) async {
    await _sharedPreferences.setString(key, token);
  }

  Future<String?> getToken(String key) async {
    return _sharedPreferences.getString(key);
  }

  Future<void> deleteToken(String key) async {
    await _sharedPreferences.remove(key);
  }


  Future<int> getInt(String key, int defaultValue) async {
    return _sharedPreferences.getInt(key) ?? defaultValue;
  }

  Future<String?> getString(String key, [String? defaultValue]) async {
    return _sharedPreferences.getString(key) ?? defaultValue;
  }

  Future<List<String>?> getStringList(String key, [List<String>? defaultValue]) async {
    return _sharedPreferences.getStringList(key) ?? defaultValue;
  }

  Future<bool> getBool(String key, bool defaultValue) async {
    return _sharedPreferences.getBool(key) ?? defaultValue;
  }

  Future<double> getDouble(String key, double defaultValue) async {
    return _sharedPreferences.getDouble(key) ?? defaultValue;
  }



  Future<void> setInt(String key, int value) async {
    await _sharedPreferences.setInt(key, value);
  }

  Future<void> setString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  Future<void> setStringList(String key, List<String> value) async {
    await _sharedPreferences.setStringList(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    await _sharedPreferences.setBool(key, value);
  }

  Future<void> setDouble(String key, double value) async {
    await _sharedPreferences.setDouble(key, value);
  }

 

  Future<bool> remove(String key) async {
    return await _sharedPreferences.remove(key);
  }

  Future<void> clear() async {
    await _sharedPreferences.clear();
  }

  Future<void> clearPreferenceData() async {
    await _sharedPreferences.clear();
  }
}
