part of 'audiomanagement_bloc.dart';

abstract class AudiomanagementEvent extends Equatable {
  const AudiomanagementEvent();

  @override
  List<Object> get props => [];
}

class CheckAllAudiFileEvent extends AudiomanagementEvent {
  List<String> listAudio;

  CheckAllAudiFileEvent({
    required this.listAudio,
  });
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
