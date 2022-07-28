part of 'hadists_bloc.dart';

abstract class HadistsEvent extends Equatable {
  const HadistsEvent();

  @override
  List<Object> get props => [];
}

class GetListBookHadists extends HadistsEvent {}

// class GetRandomHadists extends HadistsEvent {}
