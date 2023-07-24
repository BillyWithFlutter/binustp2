import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const _keyName = 'name';
  static const _keyHobby = 'hobby';

  static Future<void> addData(String name, String hobby) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
    await prefs.setString(_keyHobby, hobby);
  }

  static Future<Map<String, String>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString(_keyName) ?? '';
    String hobby = prefs.getString(_keyHobby) ?? '';
    return {'name': name, 'hobby': hobby};
  }
}
