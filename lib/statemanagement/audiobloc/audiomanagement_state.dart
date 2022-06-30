part of 'audiomanagement_bloc.dart';

abstract class AudiomanagementState extends Equatable {
  const AudiomanagementState();

  @override
  List<Object> get props => [];
}

class AudiomanagementInitial extends AudiomanagementState {}

class LoadingPlayAudioState extends AudiomanagementState {}

class FailedPlayAudioState extends AudiomanagementState {
  String messageInfo;

  FailedPlayAudioState({
    required this.messageInfo,
  });

  @override
  List<Object> get props => [messageInfo];
}
