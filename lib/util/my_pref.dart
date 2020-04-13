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

  static String getForcaToken() => getString(MyString.forcaToken);

  static setForcaToken(String value) {
    setString(MyString.forcaToken, value);
  }
}
