import 'package:shared_preferences/shared_preferences.dart';

class MCache {
  SharedPreferences? prefs;

  static MCache? _instance;

  MCache._() {
    init();
  }

  MCache._pre(SharedPreferences this.prefs);

  static MCache getInstance() {
    _instance ??= MCache._();
    return _instance!;
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  static Future<MCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = MCache._pre(prefs);
    }
    return _instance!;
  }

  setString(String key, String value) {
    prefs?.setString(key, value);
  }

  setDouble(String key, double value) {
    prefs?.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs?.setInt(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs?.setStringList(key, value);
  }

  setBool(String key, bool value) {
    prefs?.setBool(key, value);
  }

  remove(String key) {
    prefs?.remove(key);
  }

  T? get<T>(String key) {
    var result = prefs?.get(key);
    if (result != null) {
      return result as T;
    }
    return null;
  }
}
