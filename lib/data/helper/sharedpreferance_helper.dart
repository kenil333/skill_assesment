import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferanceHelper {
  final SharedPreferences prefs;
  SharedPreferanceHelper({required this.prefs});

  Future<void> setFlag(bool value) async {
    await prefs.setBool("Flag", value);
  }

  bool get getFlag => prefs.getBool("Flag") ?? false;
}
