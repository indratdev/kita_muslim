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
