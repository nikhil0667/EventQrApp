// ignore_for_file: non_constant_identifier_names, await_only_futures, file_names, avoid_print

import 'package:shared_preferences/shared_preferences.dart';
// ADMIN TOKEN "admin_token"
// STUDENT TOKEN "student_token"
//ORGANIZER TOEKN "organizer_token"

GetPreference(name) async {
  var prefs = await SharedPreferences.getInstance();
  String? deviceToken = await prefs.getString(name);
  // print(deviceToken);
  return deviceToken;
}

SetPreference(name, value) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString(name, value);
}

ClearPreference(name) async {
  var preferences = await SharedPreferences.getInstance();
  preferences.remove(name);

  print("Preferences ${preferences.getString(name)}");
}
