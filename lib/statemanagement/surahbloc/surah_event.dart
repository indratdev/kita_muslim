part of 'surah_bloc.dart';

@immutable
abstract class SurahEvent {}

class GetAllSurah extends SurahEvent {}

class ViewDetailSurah extends SurahEvent {
  int number;
  // BuildContext context;
  // Route routeName;

  ViewDetailSurah({
    required this.number,
    // required this.context,
    // required this.routeName,
  });
}

class MarkLastAyatSurah extends SurahEvent {
  String surah, ayat;

  MarkLastAyatSurah({
    required this.surah,
    required this.ayat,
  });
}

class GetLastAyatSurah extends SurahEvent {
  String surah;

  GetLastAyatSurah({
    required this.surah,
  });
}
