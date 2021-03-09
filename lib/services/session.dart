import 'package:shared_preferences/shared_preferences.dart';

class _SessionProvider {
  SharedPreferences? _prefs;

  static final _SessionProvider _singleton = _SessionProvider._internal();

  static Future<bool> init() async {
    _prefs = await SharedPreferences.getInstance().catchError((e) {
      print("shared prefrences error : $e");
      return false;
    });
    return true;
  }

  factory _SessionProvider() {
    return _singleton;
  }

  Future<dynamic> get(String key) {
    return _session.get(key);
  }

  Future<dynamic> set(String key, dynamic value) {
    return _session.set(key, value);
  }
}

class Session {
  static Future _set(String key, dynamic value) {
    return _SessionProvider().set(key, value);
  }

  static Future<bool> clear() async {
    await _set('token', '');
    await _set('posSession', '');
    return true;
  }

  static setToken(String value) => _set('token', value);
  static Future<String> get token async {
    final value = await _SessionProvider().get('token');
    if (value != null && value is String && value != '') {
      return value;
    }
    return null;
  }

  static setPosSession(PosSession value) => _set('posSession', value);
  static Future<PosSession> get posSession async {
    final json = await _SessionProvider().get('posSession');
    if (json != null && json is Map) {
      return PosSession.fromJson(json);
    }
    return null;
  }
}
