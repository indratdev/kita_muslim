import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:kita_muslim/utils/constants.dart';

class AudioManagement {
  final audioPlayer = AudioPlayer();
  String fileName;

  AudioManagement({
    this.fileName = "",
  });

  onPressedPlayButton(String fileName) async {
    // print("onpress2: ${File("assets\audios\1.mp3").exists()}");
    // print("filename :$fileName");
    // check file is exist
    // var path = "${Constants.assetsLocation}$fileName.mp3";
    // print("path : ${Constants.assetsLocation}$fileName.mp3");
    // print(
    //     "onpress: ${File("${Constants.assetsLocation}$fileName.mp33").exists()}");
    // return File("${Constants.assetsLocation}$fileName.mp3").existsSync();

    // assets\audios\1.mp3
    // var path = "${Constants.assetsLocation}$fileName.mp3";
    // print("path : $path");
    // print(File(path).existsSync());

    // import 'dart:io' ;
    // var syncPath = await path;

// for a file
    // await io.File(syncPath).exists();
    // var result = io.File(syncPath).existsSync();
    // print("path : $path");
    // print("result >>> $result");

    // var result =
    //     await audioPlayer.setSource(AssetSource("audios/${fileName}.mp3"));

    String fileNames = "${fileName}.mp3";
    String dir = (await getApplicationDocumentsDirectory()).path;
    print("dir : $dir");
    // String savePath = '$dir/$fileNames';
    String savePath = "assets/audios/1.mp3";

    //for a directory: await Directory(savePath).exists();
    if (await File(savePath).existsSync()) {
      print("File exists");
    } else {
      print("File don't exists");
    }
  }
}
