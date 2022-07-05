import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/data/providers/repository.dart';
import 'package:uuid/uuid.dart';

part 'audiomanagement_event.dart';
part 'audiomanagement_state.dart';

class AudiomanagementBloc
    extends Bloc<AudiomanagementEvent, AudiomanagementState> {
  final repo = Repository();

  AudiomanagementBloc() : super(AudiomanagementInitial()) {
    on<PlayAudioEvent>((event, emit) async {
      var isExistFileAudio = false;
      var uuid = Uuid().v1();
      try {
        // check file audio
        isExistFileAudio = await repo.isExistAudioFile(event.numberFileAudio);
        print('isExistFileAudio : $isExistFileAudio');

        //
        if (isExistFileAudio == true) {
          print("if else true");
        } else if (isExistFileAudio == false) {
          print("lempar ke emit failedplayaudio");
          // emit(FailedPlayAudioState(
          //     messageInfo: 'Surat / Ayat Surat Belum di-unduh'));
          emit(FailedPlayAudioState(
              messageInfo: 'Surat / Ayat Surat Belum di-unduh',
              status: "status $uuid"));
        }
      } catch (e) {
        // emit(FailedPlayAudioState(messageInfo: e.toString()));
        print(e.toString());
      }
    });
  }
}