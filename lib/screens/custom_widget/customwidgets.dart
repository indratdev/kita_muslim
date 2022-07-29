import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/statemanagement/surahbloc/surah_bloc.dart';

class CustomWidgets {
  static showDialog1Button(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          contentPadding: const EdgeInsets.only(top: 15.0, left: 20),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            content,
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  static showDialogUnduhAudio(
      BuildContext context, String title, String content, int indexSurah) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          contentPadding: const EdgeInsets.only(top: 15.0, left: 20),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            content,
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
                BlocProvider.of<SurahBloc>(context)
                    .add(SendIndexSurah(indexSurah: indexSurah));
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // 2
  static showDialog2Button(BuildContext context, String title, String content,
      @required Function() okButton) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          contentPadding: const EdgeInsets.only(top: 15.0, left: 20),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            content,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: okButton,
              child: const Text('Unduh', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  static showLoadingIcons(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          contentPadding: EdgeInsets.only(top: 15.0, left: 20),
          title: Text(
            "Unduh",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: ListTile(
            title: Text(
              "Sedang meng-unduh file...",
            ),
            trailing: CircularProgressIndicator.adaptive(),
          ),

          // actions: <Widget>[
          //   TextButton(
          //     style: ButtonStyle(
          //         backgroundColor: MaterialStateProperty.all(Colors.blue)),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //     child: const Text('OK', style: TextStyle(color: Colors.white)),
          //   ),
          // ],
        );
      },
    );
  }
}
