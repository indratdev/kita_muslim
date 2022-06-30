part of 'audiomanagement_bloc.dart';

abstract class AudiomanagementEvent extends Equatable {
  const AudiomanagementEvent();

  @override
  List<Object> get props => [];
}

class PlayAudioEvent extends AudiomanagementEvent {
  String numberFileAudio;

  PlayAudioEvent({
    required this.numberFileAudio,
  });
}
