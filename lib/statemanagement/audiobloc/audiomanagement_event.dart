part of 'audiomanagement_bloc.dart';

abstract class AudiomanagementEvent extends Equatable {
  const AudiomanagementEvent();

  @override
  List<Object> get props => [];
}

class CheckAudioFileEvent extends AudiomanagementEvent {
  String numberFileAudio;

  CheckAudioFileEvent({
    required this.numberFileAudio,
  });
}

class PlayAudioEvent extends AudiomanagementEvent {
  String numberFileAudio;

  PlayAudioEvent({
    required this.numberFileAudio,
  });
}
