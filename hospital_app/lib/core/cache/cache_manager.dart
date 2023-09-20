import 'package:shared_preferences/shared_preferences.dart';

mixin CacheManager {
  Future<bool> saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CacheManagerKeys.email.name, email);
    return true;
  }

  Future<bool> saveId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(CacheManagerKeys.id.name, id);
    return true;
  }

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var email = prefs.getString(CacheManagerKeys.email.name);
    return email;
  }

  Future<int?> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var id = prefs.getInt(CacheManagerKeys.id.name);
    return id;
  }

  Future<void> removeEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(CacheManagerKeys.email.name);
  }

  Future<void> removeId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(CacheManagerKeys.id.name);
  }
}

enum CacheManagerKeys { email, id }
