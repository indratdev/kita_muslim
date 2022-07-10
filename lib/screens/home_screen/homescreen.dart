import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/statemanagement/surahbloc/surah_bloc.dart';
import 'package:kita_muslim/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Constants.appName)),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Constants.iFebruaryInk1, Constants.iFebruaryInk2],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // stops: [0.1, 0.5, 0.7, 0.9],
        )),
        child: GridView.count(
          primary: false,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/bacaalquran');
                BlocProvider.of<SurahBloc>(context).add(GetAllSurah());
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Constants.iwhite,
                  borderRadius:
                      Constants.cornerRadiusBox, //BorderRadius.circular(15),
                  boxShadow: [Constants.boxShadowMenu],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Tab(
                        icon: Image.asset("assets/icons/quran.png",
                            fit: BoxFit.cover)),
                    const SizedBox(height: 10),
                    const Text(
                      "Al-Qur'an",
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/doaharian');
                BlocProvider.of<SurahBloc>(context).add(GetAllSurahHarian());
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Constants.iwhite,
                  borderRadius:
                      Constants.cornerRadiusBox, //BorderRadius.circular(15),
                  boxShadow: [Constants.boxShadowMenu],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Tab(
                        icon: Image.asset("assets/icons/doaharian.png",
                            fit: BoxFit.cover)),
                    const SizedBox(height: 10),
                    const Text(
                      "Doa Sehari-hari",
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
