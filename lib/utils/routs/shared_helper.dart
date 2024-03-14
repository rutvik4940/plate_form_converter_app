import 'package:shared_preferences/shared_preferences.dart';

void saveTheme({required bool changeTheme}) async{
SharedPreferences shr = await SharedPreferences.getInstance();
shr.setBool("theme", changeTheme);
}

Future<bool?> applyTheme() async {
  SharedPreferences shr = await SharedPreferences.getInstance();
  return shr.getBool("theme");
}