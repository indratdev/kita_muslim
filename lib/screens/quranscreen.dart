import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:kita_muslim/data/models/surah/surah_model.dart';
import 'package:kita_muslim/data/others/audioprovider.dart';
import 'package:kita_muslim/data/providers/api_providers.dart';
import 'package:kita_muslim/statemanagement/audiobloc/audiomanagement_bloc.dart';
import 'package:kita_muslim/statemanagement/surahbloc/surah_bloc.dart';
import 'package:kita_muslim/utils/constants.dart';

class QuranScreen extends StatefulWidget {
  QuranScreen({Key? key}) : super(key: key);

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  TextEditingController _searchController = TextEditingController();
  AudioProvider audioProvider = AudioProvider();
  List<Data> dataSurah = [];

  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        print(">>> download completed ");
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
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

              // check file audio is exist
              context.read<AudiomanagementBloc>().add(CheckAudioFileEvent(
                  numberFileAudio: data[index].numberOfVerses.toString()));

              Navigator.pushNamed(context, '/surahdetail');
            },
            child: Container(
              alignment: Alignment.center,
              height: 100,
              margin:
                  const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 2),
              decoration: BoxDecoration(
                  color: index % 2 == 0
                      ? Constants.iblueLight
                      : Colors.blue.shade300,
                  borderRadius: Constants.cornerRadiusBox,
                  boxShadow: [Constants.boxShadowMenuVersion2]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 4,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Wrap(
                              children: [
                                Text(
                                  '${data[index].number}.',
                                  style: const TextStyle(
                                      fontSize: Constants.sizeTextTitle),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index].name.transliteration.id,
                                        style: const TextStyle(
                                            fontSize: Constants.sizeTextTitle,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Wrap(
                                        children: [
                                          Text(
                                            '${data[index].name.translation.id} (${data[index].numberOfVerses}) ',
                                            style: const TextStyle(
                                              fontSize:
                                                  Constants.sizeSubTextTitle,
                                            ),
                                            overflow: TextOverflow.clip,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            color: Colors.transparent,
                            child: IconButton(
                              onPressed: () {
                                print(">>> download pressed");

                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Anda Yakin ?'),
                                        content: Text(
                                            'Apakah anda yakin akan mengunduh audio surah ${data[index].name.transliteration.id} ?'),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Kembali')),
                                          TextButton(
                                            onPressed: () {
                                              print('HelloWorld!');
                                              // ApiPrayerProvider()
                                              //     .getAudioResource(data[index].number);
                                            },
                                            child: const Text('Unduh'),
                                          )
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.download,
                                size: MediaQuery.of(context).size.width / 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                // ListTile(
                //   isThreeLine: true,
                //   leading: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         '${data[index].number}.',
                //         style:
                //             const TextStyle(fontSize: Constants.sizeTextTitle),
                //       ),
                //     ],
                //   ),
                //   title: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(data[index].name.transliteration.id,
                //           style: const TextStyle(
                //               fontSize: Constants.sizeTextTitle,
                //               fontWeight: FontWeight.bold)),
                //       Text(
                //         '${data[index].name.translation.id} (${data[index].numberOfVerses}) ',
                //         style: const TextStyle(
                //           fontSize: Constants.sizeSubTextTitle,
                //         ),
                //       ),
                //     ],
                //   ),
                //   subtitle:
                //       IconButton(onPressed: () {}, icon: Icon(Icons.download)),
                //   trailing: Text(
                //     data[index].name.short,
                //     style: const TextStyle(
                //       fontSize: Constants.sizeTextArabian,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
              ),
            ),
          );
        },
      ),
    );
  }
}
