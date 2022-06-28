import 'package:flutter/material.dart';
import 'package:kita_muslim/screens/homescreen.dart';
import 'package:kita_muslim/screens/quranscreen.dart';
import 'package:kita_muslim/screens/surah%20detail/surahdetailscreen.dart';

class Routes {
  Map<String, WidgetBuilder> getRoutes = {
    '/homescreen': (_) => HomeScreen(),
    '/bacaalquran': (_) => QuranScreen(),
    '/surahdetail': (_) => SurahDetailScreen(),
  };
}
