import 'package:posku/model/login.dart';
import 'package:posku/util/resource/my_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPref {
  static Future<SharedPreferences> get _instance async =>
      _prefs ??= await SharedPreferences.getInstance();
  static SharedPreferences _prefs;
  static SharedPreferences _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String getString(String key, [String defValue]) {
    return _prefsInstance.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs?.setString(key, value) ?? Future.value(false);
  }

  static bool getBool(String key, [bool defValue]) {
    return _prefsInstance.getBool(key) ?? defValue ?? false;
  }

  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs?.setBool(key, value) ?? Future.value(false);
  }

  static int getInt(String key, [int defValue]) {
    return _prefsInstance.getInt(key) ?? defValue;
  }

  static Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs?.setInt(key, value) ?? Future.value(false);
  }

  //action
  static logout() {
    //setRemember(false, null);
    setForcaToken(null);
  }

  //get value
  static String getForcaToken() => getString(MyString.KEY_FORCA_TOKEN);

  static setForcaToken(String value) {
    setString(MyString.KEY_FORCA_TOKEN, value);
  }

  static bool getRemember() => getBool(MyString.KEY_IS_REMEMBER);

  static setRemember(bool remember, Login login) {
    setBool(MyString.KEY_IS_REMEMBER, remember);
    setString(MyString.KEY_USERNAME, remember ? (login?.username ?? '') : '');
    setString(MyString.KEY_PASSWORD, remember ? (login?.password ?? '') : '');
  }

  static String getUsername() => getString(MyString.KEY_USERNAME);

  static setUsername(String value) {
    setString(MyString.KEY_USERNAME, value);
  }

  static String getPassword() => getString(MyString.KEY_PASSWORD);

  static setPassword(String value) {
    setString(MyString.KEY_PASSWORD, value);
  }

  static setRole(int roleId) {
    setInt(MyString.KEY_ROLE_USER, roleId);
  }

  static int getRole() => getInt(MyString.KEY_ROLE_USER);
}
