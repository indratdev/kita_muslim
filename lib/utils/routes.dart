import 'package:flutter/material.dart';
import 'package:kita_muslim/screens/home_screen/homescreen.dart';
import 'package:kita_muslim/screens/quranscreen.dart';
import 'package:kita_muslim/screens/surah_detail/surahdetailscreen.dart';
import 'package:kita_muslim/screens/surah_harian/doaharianscreen.dart';

class Routes {
  Map<String, WidgetBuilder> getRoutes = {
    '/homescreen': (_) => HomeScreen(),
    '/bacaalquran': (_) => QuranScreen(),
    '/surahdetail': (_) => SurahDetailScreen(),
    '/doaharian': (_) => DoaHarianScreen(),
  };
}
