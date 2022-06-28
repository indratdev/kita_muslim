import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  late SharedPreferences pref;

  markLastSurah(String surah, String ayat) async {
    pref = await SharedPreferences.getInstance();
    pref.setString(surah, ayat);
  }

  Future<String> getMarkLastSurah(String surah) async {
    pref = await SharedPreferences.getInstance();

    String stringValue = pref.getString(surah) ?? "0";
    print('shared pref value : $stringValue');
    return stringValue;
  }
}
