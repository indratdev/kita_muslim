import 'package:kita_muslim/data/models/hadits/hadistsR_model.dart';
import 'package:kita_muslim/data/models/hadits/hadists_model.dart';
import 'package:kita_muslim/data/models/surah/spesifik_surah_model.dart';
import 'package:kita_muslim/data/models/surah/surah_harian_model.dart';
import 'package:kita_muslim/data/models/surah/surah_model.dart';
import 'package:kita_muslim/data/others/audiomanagement.dart';
import 'package:kita_muslim/data/others/audioprovider.dart';
import 'package:kita_muslim/data/providers/api_providers.dart';

class Repository {
  final prayerApiProvider = ApiPrayerProvider();
  final audioManagement = AudioManagement();
  final audioProvider = AudioProvider();
  // final timeProvider = Times();
  // final locationDevice = LocationDevice();
  // final searchSurah = Surah();

  // repo Prayer Time
  // Future<PrayTimes> getDailyTimesPray(double lat, double lon) {
  //   return prayerApiProvider.getDailyTimesPray(lat, lon);
  // }

  // =========== end repo Prayer Time ===========

  // repo Time Prayer
  // MapEntry<String, dynamic> nextTimeShalat(Map<String, dynamic> times) {
  //   return timeProvider.nextTimeShalat(times);
  // }

  // Future<String> checkSelisihWaktu(String waktuAkanDatang) {
  //   return timeProvider.checkSelisihWaktu(waktuAkanDatang);
  // }

  // String currentDateLocal() {
  //   return timeProvider.currentDateLocal();
  // }

  // =========== end repo Time Prayer ===========

  // repo location
  // Future<Map<String, dynamic>> determinePosition() {
  //   print(locationDevice.determinePosition());
  //   return locationDevice.determinePosition();
  // }
  // =========== end repo location ===========

  // =========== repo surah =============================
  Future<SurahModel> getSurah() {
    return prayerApiProvider.getSurah();
  }

  Future<SpesifikSurahModel> getDetailSurah(int number) {
    return prayerApiProvider.getDetailSurah(number);
  }

  Future<List<SurahHarianModel>> getSurahHarian() {
    return prayerApiProvider.getSurahHarian();
  }

  // =========== end repo surah =========================

  // repo search surah
  // List<Data> getsearchSurah(String query, List<surah.Data> masterData) {
  //   return searchSurah.getSearchSurah(query, masterData);
  // }

  // =========== end repo search surah =========================

  // repo audio
  Future<bool> isExistAudioFile(String fileName) {
    // audioManagement.onPressedPlayButton(fileName);
    return audioManagement.onPressedPlayButton(fileName);
  }

  Future<List<String>> isAllAudioExist(int numberOfSurah) {
    return audioProvider.getAudioResource(numberOfSurah);
  }

  Future<Map<String, dynamic>> isExistAllAudiFiles(List<String> listAudioName) {
    return audioProvider.checkAllFileAudios(listAudioName);
  }

  // repo hadists
  Future<HadistsModel> getHadistBooks() {
    return prayerApiProvider.getHadistsBooks();
  }

  Future<HadistsRModel> getRandomHadist(String bookName, int number) {
    return prayerApiProvider.getRandomHadists(bookName, number);
  }
}
