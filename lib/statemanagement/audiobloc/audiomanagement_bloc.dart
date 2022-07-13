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
    on<CheckAudioFileEvent>((event, emit) async {
      var isExistFileAudio = false;
      try {
        isExistFileAudio = await repo.isExistAudioFile(event.numberFileAudio);
        if (isExistFileAudio) {
          emit(SuccessAudioExistState(isAudioExist: isExistFileAudio));
        } else {
          emit(SuccessAudioExistState(isAudioExist: false));
        }
      } catch (e) {
        print("Error when check audio exist");
        emit(FailedPlayAudioState(
            messageInfo: 'Surat / Ayat Surat Belum di-unduh',
            status: "status null"));
      }
    });

    on<PlayAudioEvent>((event, emit) async {
      var isExistFileAudio = false;
      var uuid = Uuid().v1();
      try {
        // check file audio
        isExistFileAudio = await repo.isExistAudioFile(event.numberFileAudio);
        print('isExistFileAudio : $isExistFileAudio');

        //
        if (isExistFileAudio == true) {
          emit(SuccessAudioExistState(isAudioExist: isExistFileAudio));
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

    on<CheckAudioExistEvent>((event, emit) async {
      try {
        print("***** CheckAudioExistEvent running...");
        List<String> resultListAudio =
            await repo.isAllAudioExist(event.listAudio);
        print("resultListAudio : $resultListAudio");

        var result = await repo.isExistAllAudiFiles(resultListAudio);
        emit(ResultAllAudioFilesState(statusFile: result));
      } catch (e) {
        emit(FailedCheckAllAudioFilesState(messageInfo: e.toString()));
      }
    });
  }
}
