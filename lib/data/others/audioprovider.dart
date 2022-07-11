import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioProvider {
  Future checkFolderAudios(List<String> url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var baseStorage = await getExternalStorageDirectory();

      /// buat folder
      const directoryName = "audios";
      final myDir = Directory("${baseStorage!.path}/$directoryName/");
      Directory? dir;
      if (await myDir.exists()) {
        // print(">>> Folder sudah ada !");
        // print(">>> dir : $dir");
        dir = myDir;
        downloadAudios(url, dir.path);
      } else {
        dir = await myDir.create(recursive: true);
        downloadAudios(url, dir.path);
        // print(">>> dir : $dir");
      }
    }
  }

  Future<void> downloadAudios(List<String> url, String dir) async {
    for (var urlVideo in url) {
      // get name video (replace string to get only name audio)
      String audioName = urlVideo.substring(55).replaceAll(".mp3", "");
      // check files audio already downloaded ?
      var isFileAudios = await checkFileAudios(audioName);
      if (!isFileAudios) {
        // if the file doesn't exist >> download that audio
        var task = await FlutterDownloader.enqueue(
          url: urlVideo.toString(),
          requiresStorageNotLow: true,
          savedDir: dir, //baseStorage!.path,
          showNotification:
              true, // show download progress in status bar (for Android)
          openFileFromNotification:
              true, // click on notification to open downloaded file (for Android)
          saveInPublicStorage: false,
        );
      } else {
        // if file exist
        print(">>>>> file audio sudah ada");
      }
    }
  }

  Future<bool> checkFileAudios(String nameFile) async {
    try {
      var baseStorage = await getExternalStorageDirectory();
      const directoryName = "audios";
      final myDir = Directory("${baseStorage!.path}/$directoryName/");
      var fullStringPath = "${myDir.path}$nameFile.mp3";
      var result = await File(fullStringPath).exists();
      // print(">>> mydir : ${myDir.path}");
      // print("fullString : $fullStringPath");
      // print(">>> Apakah file audio ada ? $result");
      return result;
    } catch (e) {
      // print('exception');
      print(e.toString());
      return false;
    }
  }

  Future<bool> checkAllFileAudios(List<String> allAudio) async {
    List<bool> allExist = [];
    for (var data in allAudio) {
      String audioName = data.substring(55).replaceAll(".mp3", "");
      // check files audio already downloaded ?
      allExist.add(await checkFileAudios(audioName));
    }

    // kalau list mengandung false -> berarti harus download (ada file yang
    // tidak terdownload semua
    var result = allExist.contains(false);
    print(">>>>> allExist : $allExist");
    print(">>>>> RESULT : $result");
    return result;
  }
}
