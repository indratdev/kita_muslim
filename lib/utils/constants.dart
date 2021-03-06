import 'package:flutter/material.dart';

class Constants {
  static const color1 = Color(0xFF3B2D60);
  static const color2 = Color(0xFFE78DD2);
  static const color3 = Color(0xFFDFB59C);
  static const iblueLight = Color(0xFFDDE6FF);
  static const iwhite = Color(0xFFFEFEFE);
  static const igreen = Color(0xFF377D71);

  static const iFebruaryInk1 = Color(0xFFADCCEF);
  static const iFebruaryInk2 = Color(0xFFE7F0FD);

  static const appName = 'Kita Muslim';
  static const textQuran = "Qur'an";

  static const assetsLocation = "assets\\audios\\";

  static const sizeBottomNav = 30.0;
  static const sizeTextTitle = 23.0;
  static const sizeSubTextTitle = 18.0;
  static const sizeTextArabian = 30.0;
  static const sizeTextArabianSub = 25.0;

  static var cornerRadiusBox = BorderRadius.circular(15.0);

  static BoxShadow boxShadowMenu = BoxShadow(
    color: Constants.color1.withOpacity(0.5),
    spreadRadius: 4,
    blurRadius: 10,
    offset: const Offset(0, 3), // changes position of shadow
  );

  static BoxShadow boxShadowMenuVersion2 = BoxShadow(
    color: Constants.color1.withOpacity(0.5),
    spreadRadius: 1,
    blurRadius: 3,
    // offset: const Offset(0, 1), // changes position of shadow
  );

  static BoxShadow boxShadowMenuVersion3 = BoxShadow(
    color: Constants.iFebruaryInk1.withOpacity(1),
    spreadRadius: 1,
    blurRadius: 3,
    // offset: const Offset(0, 1), // changes position of shadow
  );
}



// icon : <a href="https://www.flaticon.com/free-icons/quran" title="Quran icons">Quran icons created by BZZRINCANTATION - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/pray" title="pray icons">Pray icons created by kerismaker - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/favorite" title="favorite icons">Favorite icons created by Freepik - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/quran" title="Quran icons">Quran icons created by zafdesign - Flaticon</a>
// <a href="https://www.flaticon.com/free-icons/dua" title="dua icons">Dua icons created by Siipkan Creative - Flaticon</a>