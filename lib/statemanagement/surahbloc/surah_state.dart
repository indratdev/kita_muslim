part of 'surah_bloc.dart';

@immutable
abstract class SurahState {}

class SurahInitial extends SurahState {}

class LoadingSurahDetail extends SurahState {}

class FailureSurahDetail extends SurahState {
  String info;

  FailureSurahDetail({
    required this.info,
  });

  @override
  List<Object> get props => [info];
}

class SuccessGetSurahDetail extends SurahState {
  SpesifikSurahModel data;
  // String status;
  // var uuid = Uuid().v1();

  SuccessGetSurahDetail({
    required this.data,
    // this.status = "",
    // required this.context,
    // required this.routeName,
  });

  @override
  List<Object> get props => [data];
}

class LoadingMarkLastAyatSurah extends SurahState {}

class FailureMarkLastAyatSurah extends SurahState
    implements FailureSurahDetail {
  @override
  String info;

  FailureMarkLastAyatSurah({
    required this.info,
  });

  @override
  // TODO: implement props
  List<Object> get props => [info];
}

class SuccessMarkLastAyatSurah extends SurahState {}

class SuccessGetLastAyatSurah extends SurahState {
  String ayat;

  SuccessGetLastAyatSurah({
    required this.ayat,
  });
}

class FailureGetLastAyatSurah extends FailureSurahDetail {
  FailureGetLastAyatSurah({required String info}) : super(info: info);
}

class LoadingSurah extends SurahState {}

class FailureSurah extends SurahState {
  String errorMessage;

  FailureSurah({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

class SuccessGetSurah extends SurahState {
  SurahModel surah;

  SuccessGetSurah({
    required this.surah,
  });

  @override
  List<Object> get props => [surah];
}

class SuccessGetSurahHarian extends SurahState {
  List<SurahHarianModel> surah;

  SuccessGetSurahHarian({
    required this.surah,
  });

  @override
  List<Object> get props => [surah];
}
