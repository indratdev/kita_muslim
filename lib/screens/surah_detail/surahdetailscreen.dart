import 'dart:isolate';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:kita_muslim/data/others/audioprovider.dart';
import 'package:kita_muslim/screens/custom_widget/customwidgets.dart';
import 'package:kita_muslim/statemanagement/audiobloc/audiomanagement_bloc.dart';
import 'package:kita_muslim/statemanagement/surahbloc/surah_bloc.dart';
import 'package:kita_muslim/utils/constants.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SurahDetailScreen extends StatefulWidget {
  SurahDetailScreen({Key? key}) : super(key: key);

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final audioPlayer = AudioPlayer();
  final audioCache = AudioCache(prefix: 'assets/audios/');

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isAudioFileExist = false;

  String indexAyat = "0";
  String surahName = "";
  List<String> listAudioDwn = [];
  List<String> listAudioPlay = [];
  int _numberAudioPlay = 0;
  bool _isPlay = false;

  bool _isFavorite = false;

  ReceivePort _port = ReceivePort();

  @override
  void dispose() async {
    // audioPlayer.dispose();
    // await audioPlayer.release();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // start flutter_downloader
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      print("@@@>>>>>> progress : $progress");

      if (status == DownloadTaskStatus.complete) {
        print(">>> download completed ");
      } else if (status == DownloadTaskStatus.running) {
        print("**** downloading progress : $progress");
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
    // end flutter_downloader

    // listen to state: playinh, pause, stopped
    // audioPlayer.onPlayerStateChanged.listen((event) {
    //   setState(() {
    //     isPlaying = event == PlayerState.playing;
    //   });
    // });

    audioPlayer.onPlayerComplete.listen((event) {
      print(">>> done audio <<<");
      if (_numberAudioPlay < listAudioPlay.length - 1) {
        _numberAudioPlay += 1;
        playAudio();
        setState(() {});
      } else {
        stopAudio();
      }
    });
  }

  stopAudio() {
    // print("stopAudio Running ");
    audioPlayer.stop();
    _isPlay = false;
    _numberAudioPlay = 0;

    setState(() {});
  }

  playAudio() async {
    print(">>> playing ${listAudioPlay[_numberAudioPlay]}.......");
    if (_numberAudioPlay <= listAudioPlay.length - 1) {
      setState(() {
        _isPlay = true;
        scrollToIndex(_numberAudioPlay);
      });
      await audioPlayer.play(DeviceFileSource(listAudioPlay[_numberAudioPlay]));
    }
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  // scroll to index
  void scrollToIndex(int index) {
    _itemScrollController.scrollTo(
        index: index,
        duration: const Duration(seconds: 3),
        curve: Curves.easeInOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // back button
      onWillPop: () async {
        BlocProvider.of<SurahBloc>(context).add(GetAllSurah());
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Surah'),
            actions: <Widget>[
              Row(
                children: [
                  // FavoriteWidgetSurah(isFavorite: _isFavorite),

                  // icon download, jika file audio tidak ada akan tampil icon nya.
                  BlocBuilder<AudiomanagementBloc, AudiomanagementState>(
                    builder: (context, state) {
                      // if audio file haven't download, this icon will be show
                      if (state is ResultAllAudioFilesState) {
                        listAudioDwn = state.statusFile["listAudio"];
                        listAudioPlay = state.statusFile["fileNameAudio"];
                        // print("length listAudioPlay : ${listAudioPlay.length}");
                        // print("%%%%% ${state.statusFile["fileNameAudio"]}");
                        // print("%%%%% ${state.statusFile["listAudio"]}");
                        if (state.statusFile["audioStatus"] == true) {
                          return IconButton(
                            onPressed: () {
                              // download icon
                              CustomWidgets.showDialog2Button(
                                context,
                                "Unduh Audio",
                                "Apakah anda yakin akan meng-unduh audio $surahName ? ",
                                () {
                                  AudioProvider()
                                      .checkFolderAudios(listAudioDwn);

                                  // context.read<AudiomanagementBloc>().add(
                                  //     DownloadListAudioEvent(
                                  //         listAudio: listAudioDwn));
                                  Navigator.pop(context);
                                },
                              );
                              // AudioProvider().checkFolderAudios(listAudioDwn);
                            },
                            icon: const Icon(Icons.download),
                          );
                        } else if (state.statusFile['audioStatus'] == false) {
                          // if files audio has downloaded, icon play audio showed
                          return IconButton(
                            onPressed: () async {
                              (!_isPlay) ? playAudio() : stopAudio();
                            },
                            icon: (!_isPlay)
                                ? const Icon(Icons.play_circle_fill_outlined)
                                : const Icon(Icons.stop_circle_outlined),
                          );
                        }
                      }
                      return Container();
                    },
                  ),

                  // popup menu
                  PopupMenuButton(
                    elevation: 20,
                    icon: const Icon(Icons.more_horiz),
                    color: Constants.iwhite,
                    shape: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    onSelected: (value) {
                      switch (value) {
                        case 0:
                          (indexAyat == "0")
                              ? //scrollToIndex(0)
                              CustomWidgets.showDialog1Button(
                                  context,
                                  "Menandai Surah",
                                  "Anda belum menadai surah ini !")
                              : scrollToIndex(int.parse(indexAyat) - 1);
                          break;

                        // case 1:
                        //   print("unduh audio run");
                        //   // belum selese --> ke proses download audio
                        //   break;

                        default:
                          (indexAyat == "0")
                              ? //scrollToIndex(0)
                              CustomWidgets.showDialog1Button(
                                  context,
                                  "Menandai Surah",
                                  "Anda belum menadai surah ini !")
                              : scrollToIndex(int.parse(indexAyat) - 1);
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text(
                          'Ke Terakhir dibaca',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // PopupMenuItem<int>(
                      //   value: 1,
                      //   enabled: (isAudioFileExist) ? true : false,
                      //   child: const Text(
                      //     'Unduh Audio',
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //     ),
                      //   ),
                      // ),
                    ],
                    // onSelected: (item) => {print(item)},
                  ),
                ],
                // );
                // },
              ),
            ],
          ),
          body: BlocConsumer<SurahBloc, SurahState>(
            listener: (context, state) {
              if (state is SuccessMarkLastAyatSurah) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Berhasil Menandai Surat',
                      style: TextStyle(color: Colors.green),
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            builder: (context, state) {
              print("state >>>> $state");

              if (state is SuccessGetFavoriteSurah) {
                _isFavorite = true; //state.isFavorite;
              }

              if (state is SuccessGetLastAyatSurah) {
                indexAyat = state.ayat;
              }

              // loading surah
              if (state is LoadingSurahDetail) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (state is FailureSurahDetail) {
                print(state.info.toString());
                return Center(child: Text(state.info.toString()));
              } else if (state is SuccessGetSurahDetail) {
                var data = state.data.data;
                surahName =
                    data.name.transliteration.id.toString(); // set surah name

                return Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [Constants.boxShadowMenu],
                          color: Constants.iwhite,
                        ),
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          '${data.name.transliteration.id} (${data.name.translation.id})\n${data.revelation.id} ${data.numberOfVerses} Ayat',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Constants.sizeTextTitle,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ScrollablePositionedList.builder(
                        itemScrollController: _itemScrollController,
                        itemCount: data.numberOfVerses,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              var surah =
                                  data.name.transliteration.id.toString();

                              var ayat =
                                  data.verses[index].number.inSurah.toString();
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) => CupertinoActionSheet(
                                  title: Text(surah + ' : Ayat ' + ayat),
                                  actions: <Widget>[
                                    CupertinoActionSheetAction(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 5.0, left: 5),
                                              title: const Text(
                                                'Menandai Surah',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              content: const Text(
                                                  'Anda akan menandai terakhir baca pada surat : ayat , yakin ?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();

                                                    BlocProvider.of<SurahBloc>(
                                                            context)
                                                        .add(MarkLastAyatSurah(
                                                            surah: surah,
                                                            ayat: ayat));
                                                    BlocProvider.of<SurahBloc>(
                                                            context)
                                                        .add(ViewDetailSurah(
                                                            number:
                                                                data.number));
                                                    BlocProvider.of<SurahBloc>(
                                                            context)
                                                        .add(GetLastAyatSurah(
                                                            surah: surah));
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'Batal',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child:
                                          const Text('Tandai Terakhir Dibaca'),
                                    ),
                                  ],
                                  cancelButton: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel',
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(10),
                                color: index % 2 == 0
                                    ? Constants.iwhite
                                    : Constants.iblueLight,
                              ),
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, right: 5, left: 5),
                              child: Column(
                                children: <Widget>[
                                  BlocConsumer<AudiomanagementBloc,
                                      AudiomanagementState>(
                                    listener: (context, state) {
                                      if (state is FailedPlayAudioState) {
                                        print("gagal audio");
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'GAGAL Audio',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            duration: Duration(
                                              seconds: 2,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                  data.verses[index].number
                                                      .inSurah
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: Constants
                                                          .sizeTextTitle)),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 8,
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: ListView(
                                                physics:
                                                    const ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                children: <Widget>[
                                                  Text(
                                                    data.verses[index].text
                                                        .arab,
                                                    textAlign: TextAlign.right,
                                                    style: const TextStyle(
                                                        fontSize: Constants
                                                            .sizeTextArabian),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    data.verses[index].text
                                                        .transliteration.en
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: Constants
                                                            .sizeTextTitle),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    data.verses[index]
                                                        .translation.id
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: Constants
                                                            .sizeTextTitle,
                                                        color: Colors.blueAccent
                                                            .shade200),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          (isAudioFileExist) // kalau file audio udah ada akan tampil tombol play
                                              ? Flexible(
                                                  flex: 2,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      isPlaying
                                                          ? Icons.pause
                                                          : Icons.play_circle,
                                                      size: 35,
                                                    ),
                                                    onPressed: () async {
                                                      // await audioPlayer.setSource(AssetSource(
                                                      //     "audios/${data.verses[index].number.inQuran}.mp3"));

                                                      // await audioPlayer.resume();
                                                      // print(">>>>>>>>> audi jalan");
                                                      // onPressedPlayButton(data
                                                      //     .verses[index].number.inQuran
                                                      //     .toString());
                                                      BlocProvider.of<
                                                                  AudiomanagementBloc>(
                                                              context)
                                                          .add(PlayAudioEvent(
                                                              numberFileAudio: data
                                                                  .verses[index]
                                                                  .number
                                                                  .inQuran
                                                                  .toString()));
                                                    },
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

class FavoriteWidgetSurah extends StatelessWidget {
  bool isFavorite;

  FavoriteWidgetSurah({
    Key? key,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // action favorite button
      },
      icon: Icon(
        Icons.favorite,
        color: (!isFavorite) ? Colors.white : Colors.red,
        // color:  Colors.amber,
        // (resultIsFavorite) ? Colors.red : Colors.black,
      ),
    );
  }
}
