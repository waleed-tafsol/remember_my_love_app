import 'package:remember_my_love_app/utills/Colored_print.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const String _authTokenKey = 'auth_token';
  static const String _uploadKeys = 'upload_keys';

  // Save token to local storage
  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authTokenKey, token);
    ColoredPrint.green("Auth Token:    $token");
  }

// VideoKeys
  Future<void> saveVideosKeys(List<String> keys) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_uploadKeys, keys);
    ColoredPrint.green("keys:  $keys");
  }

  Future<List<String>?> getVideoKeys() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getStringList(_uploadKeys);
    ColoredPrint.green("Video Keys:    $token");
    return token;
  }

  Future<void> deleteVideosKeys() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_uploadKeys);
    ColoredPrint.red("Video keys Deleted");
  }

  Future<bool> hasVideoKeys() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_uploadKeys);
  }

  // Retrieve token from local storage
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_authTokenKey);
    ColoredPrint.green("Auth Token:    $token");
    return token;
  }

  // Delete token from local storage
  Future<void> deleteToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authTokenKey);
    ColoredPrint.red("Auth Token:  Removed");
  }

  // Check if the token exists (for authentication status)
  Future<bool> hasToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_authTokenKey);
  }
}
