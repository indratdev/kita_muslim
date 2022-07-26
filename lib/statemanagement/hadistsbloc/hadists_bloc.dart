import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/data/models/hadits/hadists_model.dart';
import 'package:kita_muslim/data/providers/repository.dart';
import 'dart:math';

part 'hadists_event.dart';
part 'hadists_state.dart';

class HadistsBloc extends Bloc<HadistsEvent, HadistsState> {
  final repo = Repository();

  HadistsBloc() : super(HadistsInitial()) {
    on<GetListBookHadists>((event, emit) async {
      try {
        emit(LoadingHadistsBooks());
        print("jalan");
        var result = await repo.getHadistBooks();

        int maxBooks = result.data.length;
        Random random = Random();
        int randomNumber = random.nextInt(maxBooks);
        int randomNumberHadist = random.nextInt(
            result.data[randomNumber].available); // get random hadist number
        String randomBookName = result.data[randomNumber].id;

        var resultRandom =
            await repo.getRandomHadist(randomBookName, randomNumberHadist);

        print("@@@ ${resultRandom.data[0].name}");
        print(">>> result : ${result.data}");
        emit(SuccessHadistsBooks(result: result));
      } catch (e) {
        print("error : $e");
        emit(FailureHadistsBooks(message: e.toString()));
      }
    });
  }
}
