import 'dart:io';
// import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:audioplayers/audioplayers.dart';

import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;

class AudioManagement {
  final audioPlayer = AudioPlayer();
  String fileName;

  AudioManagement({
    this.fileName = "",
  });

  Future<bool> onPressedPlayButton(String fileName) async {
    bool result = false;
    try {
      String textasset =
          "assets/audios/$fileName.mp3"; //path to text file asset
      var text = await rootBundle.load(textasset);
      print(">>>>> text asset : $text , filename : $fileName");
      if (text != "") {
        result = true;
        print(">>> file audio ada");
      } else {
        result = false;
        print(">>> file audio tidak ada");
      }
    } catch (e) {
      print(">>>> Error file audio tidak ada : ${e.toString()}");
      result = false;
    }
    return result;
  }
}
