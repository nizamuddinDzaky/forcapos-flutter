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

  //action
  static logout() {
    //setRemember(false, null);
    setForcaToken(null);
  }

  //get value
  static String getForcaToken() => getString(MyString.forcaToken);

  static setForcaToken(String value) {
    setString(MyString.forcaToken, value);
  }

  static bool getRemember() => getBool(MyString.isRemember);

  static setRemember(bool remember, Login login) {
    setBool(MyString.isRemember, remember);
    setString(MyString.username, remember ? (login?.username ?? '') : '');
    setString(MyString.password, remember ? (login?.password ?? '') : '');
  }

  static String getUsername() => getString(MyString.username);

  static setUsername(String value) {
    setString(MyString.username, value);
  }

  static String getPassword() => getString(MyString.password);

  static setPassword(String value) {
    setString(MyString.password, value);
  }
}
