part of 'audiomanagement_bloc.dart';

abstract class AudiomanagementState extends Equatable {
  const AudiomanagementState();

  @override
  List<Object> get props => [];
}

class AudiomanagementInitial extends AudiomanagementState {}

class LoadingPlayAudioState extends AudiomanagementState {}

class SuccessAudioExistState extends AudiomanagementState {
  bool isAudioExist;

  SuccessAudioExistState({
    required this.isAudioExist,
  });

  @override
  List<Object> get props => [isAudioExist];
}

class FailedPlayAudioState extends AudiomanagementState {
  String messageInfo;
  // var uuid = Uuid().v1();
  String status;

  FailedPlayAudioState({
    required this.messageInfo,
    required this.status,
    // this.uuid = "",
  });

  @override
  List<Object> get props => [messageInfo, status];
}

class ResultAllAudioFilesState extends AudiomanagementState {
  bool statusFile;

  ResultAllAudioFilesState({
    required this.statusFile,
  });

  @override
  List<Object> get props => [statusFile];
}

class FailedCheckAllAudioFilesState extends AudiomanagementState {
  String messageInfo;

  FailedCheckAllAudioFilesState({
    required this.messageInfo,
  });

  @override
  List<Object> get props => [messageInfo];
}
