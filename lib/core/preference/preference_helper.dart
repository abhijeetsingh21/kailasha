import 'dart:convert';

import 'package:kailasha/core/preference/preference.dart';
import 'package:kailasha/models/user_data/user_data.dart';

class PreferenceHelper {
  static const userEmail = "user_email";
  static const accessToken = "access_token";
  static const refreshToken = "refresh_token";
  static const isLogin = "is_login";
  static const userData = "user_data";
  static const firstLoginData = "first_login_data";
  static const loginData = "login_data";
  static const loginDateTime = "login_time";
  static const toCountry = "to-country";
  static const fromCountry = "from-country";
  static const savedWordData = "saved_word_data";
  static const onBoardedState = "onboarded-state";
  static const proficiency = "proficiency-level";
  static const deviceUuId = "device_uuid";
  static const String langKey = 'selected_language';

  // Access token methods

  static Future<String?> getAccessToken() async {
    return await Preferences().getToken(accessToken);
  }

  static Future<void> setAccessToken(String token) async {
    await Preferences().setToken(accessToken, token);
  }

  static Future<void> deleteAccessToken() async {
    await Preferences().deleteToken(accessToken);
  }

  static Future<String?> getRefreshToken() async {
    return await Preferences().getToken(refreshToken);
  }

  static Future<void> setRefreshToken(String token) async {
    await Preferences().setToken(refreshToken, token);
  }

  static Future<void> deleteRefreshToken() async {
    await Preferences().deleteToken(refreshToken);
  }

  // Login status methods
  static Future<bool> getIsLogin() async {
    return await Preferences().getBool(isLogin, false);
  }

  static Future<void> setIsLogin(bool value) async {
    await Preferences().setBool(isLogin, value);
  }

  static Future<void> setOnBoardedState(bool value) async {
    await Preferences().setBool(onBoardedState, value);
  }

  static Future<bool> getOnBoardedState() async {
    return await Preferences().getBool(onBoardedState, false);
  }

  // User email methods
  static Future<void> setUserEmail(String email) async {
    await Preferences().setString(userEmail, email);
  }

  static Future<String?> getUserEmail() async {
    return Preferences().getString(userEmail, null);
  }

  static Future<void> setProficiency(String value) async {
    await Preferences().setString(proficiency, value);
  }

  static Future<String> getLanguage() async {
    return await Preferences().getString(langKey, 'en') ?? 'en';
  }

  static Future<void> setLanguage(String langCode) async {
    return await Preferences().setString(langKey, langCode);
  }

  static Future<String?> getProficiency() async {
    return await Preferences().getString(proficiency, null);
  }

  static Future<void> setDeviceUuId(String value) async {
    await Preferences().setString(deviceUuId, value);
  }

  static Future<String?> getDeviceUuId() async {
    return await Preferences().getString(deviceUuId, null);
  }

  // Login time methods

  static Future<String?> getLoginTime() async {
    return Preferences().getString(loginDateTime, null);
  }

  // Data clearing methods
  static Future<void> clearFirstLogin() async {
    await Preferences().remove(firstLoginData);
  }

  //User data methods
  static setUserData(UserData? model) async {
    final data = jsonEncode(model?.toJson());
    await Preferences().setString(userData, data);
  }

  static Future<UserData?> getUserData() async {
    final localUserData = await Preferences().getString(userData, null);
    if (localUserData != null) {
      final data = UserData.fromJson(jsonDecode(localUserData));
      return data;
    }
  }

  static Future<void> clearAllPreferences() async {
    await Preferences().clearPreferenceData();
    await Preferences().remove(accessToken);
    await Preferences().remove(isLogin);
    await Preferences().remove(userEmail);
    await Preferences().remove(userData);
    await Preferences().remove(firstLoginData);
    await Preferences().remove(loginData);
    await Preferences().remove(loginDateTime);
    await Preferences().remove(toCountry);
    await Preferences().remove(fromCountry);
    await Preferences().remove(savedWordData);
    await Preferences().remove(refreshToken);
    await Preferences().remove(onBoardedState);
    await Preferences().remove(proficiency);
  }
}
