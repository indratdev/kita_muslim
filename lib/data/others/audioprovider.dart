import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:kita_muslim/data/providers/api_providers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MyDownloadableItem {
  String name = "";
  // String url = "";
}

class AudioProvider {
  final apiProvider = ApiPrayerProvider();
  final directoryName = "audios";
  Map<String, MyDownloadableItem> _taskToItem = {};

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
        var taskId = await FlutterDownloader.enqueue(
          url: urlVideo.toString(),
          requiresStorageNotLow: true,
          savedDir: dir, //baseStorage!.path,
          showNotification:
              true, // show download progress in status bar (for Android)
          openFileFromNotification:
              true, // click on notification to open downloaded file (for Android)
          saveInPublicStorage: false,
        );
        // _taskToItem[taskId!] = urlVideo.toString() as MyDownloadableItem;
      } else {
        // if file exist
        print(">>>>> file audio sudah ada");
      }
    }
  }

  Future<bool> checkFileAudios(String nameFile) async {
    try {
      var baseStorage = await getExternalStorageDirectory();
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

  Future<String> getAudioFileLocation(String audioFileName) async {
    String resultAudio = "";
    try {
      var baseStorage = await getExternalStorageDirectory();
      final myDir = Directory("${baseStorage!.path}/$directoryName/");
      // for (var value in listAudio) {
      // return  "${myDir.path}$value.mp3";
      // resultListAudio.add("${myDir.path}$listAudio.mp3");
      resultAudio = "${myDir.path}$audioFileName.mp3";
      // }
      // return resultListAudio;
      // var fullStringPath = "${myDir.path}$nameFile.mp3";
      return resultAudio;
    } catch (e) {
      // return [];
      return "";
    }
  }

  Future<Map<String, dynamic>> checkAllFileAudios(List<String> allAudio) async {
    Map<String, dynamic> result = <String, dynamic>{};
    List<bool> allExist = [];
    List<String> filenameAudio = [];

    for (var data in allAudio) {
      String audioName = data.substring(55).replaceAll(".mp3", "");
      // filenameAudio.add(audioName);
      var resultLocation = await getAudioFileLocation(audioName);
      // print(">>>> resultLocation : $resultLocation");
      if (resultLocation != "") {
        filenameAudio.add(resultLocation);
      }

      // check files audio already downloaded ?
      allExist.add(await checkFileAudios(audioName));
    }

    // kalau list mengandung false -> berarti harus download (ada file yang
    // tidak terdownload semua
    var resultAudioExist = allExist.contains(false);
    // print(">>>>> allExist : $allExist");
    // print(">>>>> RESULT : $result");

    result["audioStatus"] = resultAudioExist;
    result["listAudio"] = allAudio;
    result["fileNameAudio"] = filenameAudio;

    // print("@@@@ result : $result");
    return result;
  }

  Future<List<String>> getAudioResource(int number) async {
    var result = await apiProvider.getDetailSurah(number);
    List<String> urlAudio = [];

    for (var data in result.data.verses) {
      urlAudio.add(data.audio.secondary[0].toString());
    }
    // print(urlAudio);
    return urlAudio;
  }
}
