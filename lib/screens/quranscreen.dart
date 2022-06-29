import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/data/models/surah/surah_model.dart';
import 'package:kita_muslim/statemanagement/surahbloc/surah_bloc.dart';
import 'package:kita_muslim/utils/constants.dart';

class QuranScreen extends StatefulWidget {
  QuranScreen({Key? key}) : super(key: key);

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Data> dataSurah = [];

  @override
  void initState() {
    super.initState();

    print(">>>> ulang");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Surat Al-Qur'an"),
        ),
        body: Column(
          children: <Widget>[
            BlocBuilder<SurahBloc, SurahState>(
              builder: (context, state) {
                if (state is FailureSurah) {
                  return Center(
                      child: Text('Error : ${state.errorMessage.toString()}'));
                }
                if (state is LoadingSurah) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  );
                }
                if (state is SuccessGetSurah) {
                  var data = state.surah.data;
                  dataSurah = data;

                  return Expanded(
                    child: Column(
                      children: [
                        listviewBody(data: data),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class listviewBody extends StatelessWidget {
  listviewBody({
    Key? key,
    required this.data,
  }) : super(key: key);

  List<Data> data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              context
                  .read<SurahBloc>()
                  .add(ViewDetailSurah(number: data[index].number));

              // check have you ever read
              context.read<SurahBloc>().add(
                  GetLastAyatSurah(surah: data[index].name.transliteration.id));

              Navigator.pushNamed(context, '/surahdetail');
            },
            child: Container(
              // padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              height: 100,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: index % 2 == 0
                    ? Constants.iblueLight
                    : Colors.blue.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Text(
                    '${data[index].number}.',
                    style: TextStyle(fontSize: Constants.sizeTextTitle),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(data[index].name.transliteration.id,
                          style: TextStyle(
                              fontSize: Constants.sizeTextTitle,
                              fontWeight: FontWeight.bold)),
                      Text(
                        data[index].name.translation.id +
                            ' (' +
                            data[index].numberOfVerses.toString() +
                            ') ',
                        style: const TextStyle(
                          fontSize: Constants.sizeSubTextTitle,
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    data[index].name.short,
                    style: const TextStyle(
                      fontSize: Constants.sizeTextArabian,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
