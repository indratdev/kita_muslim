part of 'hadists_bloc.dart';

abstract class HadistsState extends Equatable {
  const HadistsState();

  @override
  List<Object> get props => [];
}

class HadistsInitial extends HadistsState {}

class LoadingHadistsBooks extends HadistsState {}

class FailureHadistsBooks extends HadistsState {
  String message;

  FailureHadistsBooks({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class SuccessHadistsBooks extends HadistsState {
  HadistsModel result;

  SuccessHadistsBooks({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
