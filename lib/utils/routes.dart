import 'package:flutter/material.dart';
import 'package:kita_muslim/screens/homescreen.dart';
import 'package:kita_muslim/screens/quranscreen.dart';

class Routes {
  Map<String, WidgetBuilder> getRoutes = {
    '/homescreen': (_) => HomeScreen(),
    '/bacaalquran': (_) => QuranScreen(),

    // '/othersmenu': (_) => OthersMenu(),
  };
}
