import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/statemanagement/surahbloc/surah_bloc.dart';

/// https://doa-doa-api-ahmadramadhan.fly.dev/api
///
///
class DoaHarianScreen extends StatelessWidget {
  const DoaHarianScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SurahBloc, SurahState>(
        builder: (context, state) {
          if (state is SuccessGetSurahHarian) {
            var result = state.surah;
            return ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, index) {
                return Container(
                  // decoration: BoxDecoration(border:),
                  padding: EdgeInsets.all(10),
                  child: Text("$index ${result[index].doa.toString()}"),
                );
              },
            );
          } else {
            return Container(
              child: Text('datasss'),
            );
          }
        },
      ),
    );
  }
}
