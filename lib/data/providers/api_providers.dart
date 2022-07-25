import 'dart:convert';

import 'package:kita_muslim/data/models/surah/spesifik_surah_model.dart';
import 'package:kita_muslim/data/models/surah/surah_harian_model.dart';
import 'package:kita_muslim/data/models/surah/surah_model.dart';
import 'package:http/http.dart' as http;

class ApiPrayerProvider {
  // String baseUrl2 = 'https://api.quran.sutanlab.id';
  String baseUrl = 'https://quran-api-mu.vercel.app/';

  // final currentTime = Times().currentTime();

  // Future<PrayTimes> getDailyTimesPray(double lat, double lon) async {
  //   Uri url = Uri.parse(
  //       'https://api.pray.zone/v2/times/day.json?date=$currentTime&longitude=$lon&latitude=$lat');
  //   // 'https://api.pray.zone/v2/times/day.json?date=2022-04-07&longitude=-73.935242&latitude=40.730610'); // new york times
  //   var response = await http.get(url);
  //   var result = jsonDecode(response.body);

  //   if (result['code'] == 200 && result['status'] == "OK") {
  //     return PrayTimes.fromJson(result['results']);
  //   } else {
  //     throw Exception('failed');
  //   }
  // }

  Future<SurahModel> getSurah() async {
    Uri url = Uri.parse('$baseUrl/surah');
    // print(">>> url : $url");
    var response = await http.get(url);
    // print(">>> response : $response");
    var result = jsonDecode(response.body);
    // print('data ===> ${result}');

    if (result['code'] == 200 || result['status'] == 'OK.') {
      return SurahModel.fromJson(result);
    } else {
      throw Exception('Failed Get Surah');
    }
  }

  Future<List<SurahHarianModel>> getSurahHarian() async {
    Uri url = Uri.parse("https://doa-doa-api-ahmadramadhan.fly.dev/api");
    var response = await http.get(url);
    var result = jsonDecode(response.body) as List;

    if (result.length > 0 || result.isNotEmpty) {
      List<SurahHarianModel> finalResult =
          result.map((e) => SurahHarianModel.fromJson(e)).toList();
      return finalResult;
    } else {
      throw Exception('Failed Get Surah');
    }
  }

  Future<SpesifikSurahModel> getDetailSurah(int number) async {
    Uri url = Uri.parse('$baseUrl/surah/$number');
    var response = await http.get(url);
    var result = jsonDecode(response.body);

    if (result['code'] == 200 || result['code'] == 'OK.') {
      // var data = result['data'];
      return SpesifikSurahModel.fromJson(result);
    } else {
      throw Exception('Failed Get Detail Surah');
    }
  }
}
