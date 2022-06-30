import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/data/providers/repository.dart';

part 'audiomanagement_event.dart';
part 'audiomanagement_state.dart';

class AudiomanagementBloc
    extends Bloc<AudiomanagementEvent, AudiomanagementState> {
  final repo = Repository();

  AudiomanagementBloc() : super(AudiomanagementInitial()) {
    on<PlayAudioEvent>((event, emit) {
      try {
        emit(LoadingPlayAudioState());

        // check file audio
        var isExistFileAudio = repo.isExistAudioFile(event.numberFileAudio);
        print('isExistFileAudio : $isExistFileAudio');
        // (isExistFileAudio)
        //     ? 'true'
        //     : emit(FailedPlayAudioState(
        //         messageInfo: 'Surat / Ayat Surat Belum di-unduh'));
        if (isExistFileAudio == true) {
          print("if else true");
        } else {
          emit(FailedPlayAudioState(
              messageInfo: 'Surat / Ayat Surat Belum di-unduh'));
        }
      } catch (e) {
        emit(FailedPlayAudioState(messageInfo: e.toString()));
      }
    });
  }
}
