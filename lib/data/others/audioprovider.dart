import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioProvider {
  Future processDownload(String url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var baseStorage = await getExternalStorageDirectory();

      /// buat folder
      const directoryName = "audios";
      // final docDir = await getApplicationDocumentsDirectory();
      final myDir = Directory("${baseStorage!.path}/$directoryName/");
      Directory? dir;

      if (await myDir.exists()) {
        print(">>> Folder sudah ada !");
        dir = myDir;
        print(">>> dir : $dir");
        download(url, dir.path);
      } else {
        dir = await myDir.create(recursive: true);
        download(url, dir.path);
        print(">>> dir : $dir");
      }

      // baseStorage = "${baseStorage!.path}/audios/" as Directory?;
      // print(">>> basesotrage : ${baseStorage} ");

    }
  }

  Future<void> download(String url, String dir) async {
    await FlutterDownloader.enqueue(
      url: url,
      requiresStorageNotLow: true,
      savedDir: dir, //baseStorage!.path,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
      saveInPublicStorage: false,
    );
  }

  Future<void> ReadFile(String nameFile) async {
    try {
      var baseStorage = await getExternalStorageDirectory();
      const directoryName = "audios";
      final myDir = Directory("${baseStorage!.path}/$directoryName/");
      print(">>> mydir : ${myDir.path}");
      var fullStringPath = "${myDir.path}$nameFile.mp3";
      print("fullString : $fullStringPath");

      var result = await File(fullStringPath).exists();

      print(">>> Apakah file audio ada ? $result");
    } catch (e) {
      print('exception');
      print(e.toString());
    }
  }
}
