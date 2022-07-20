import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/statemanagement/surahbloc/surah_bloc.dart';

import '../../utils/constants.dart';

/// https://doa-doa-api-ahmadramadhan.fly.dev/api
///
///
class DoaHarianScreen extends StatelessWidget {
  const DoaHarianScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doa - doa harian"),
        centerTitle: true,
      ),
      body: BlocBuilder<SurahBloc, SurahState>(
        builder: (context, state) {
          if (state is LoadingSurah) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is SuccessGetSurahHarian) {
            var result = state.surah;
            return ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context.read<SurahBloc>().add(
                        SendDoaHarianDetailEvent(surah: state.surah[index]));
                    Navigator.pushNamed(context, '/doahariandetail');
                  },
                  child: Container(
                      alignment: Alignment.centerLeft,
                      height: 80,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 5),
                      decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? Constants.iblueLight
                              : Colors.blue.shade300,
                          borderRadius: Constants.cornerRadiusBox,
                          boxShadow: [Constants.boxShadowMenuVersion2]),
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        minLeadingWidth: 5,
                        leading: Text(
                          "${index + 1}.",
                          style: const TextStyle(
                            // fontWeight: FontWeight.w500,
                            fontSize: Constants.sizeSubTextTitle,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        title: Text(
                          result[index].doa.toString(),
                          style: const TextStyle(
                            // fontWeight: FontWeight.w500,
                            fontSize: Constants.sizeSubTextTitle,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      )
                      // Text(
                      //   "${index + 1}. ${result[index].doa.toString()}",
                      //   style: const TextStyle(
                      //     fontWeight: FontWeight.w500,
                      //     fontSize: Constants.sizeTextTitle,
                      //     overflow: TextOverflow.clip,
                      //   ),
                      // ),
                      ),
                );
              },
            );
          } else {
            return Container(
                // child: Text('datasss'),
                );
          }
        },
      ),
    );
  }
}
