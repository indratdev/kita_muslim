import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/statemanagement/hadistsbloc/hadists_bloc.dart';
import 'package:kita_muslim/utils/constants.dart';

class HadistScreen extends StatelessWidget {
  const HadistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hadist'),
      ),
      body: Column(
        children: <Widget>[
          BlocBuilder<HadistsBloc, HadistsState>(
            builder: (context, state) {
              if (state is LoadingHadistsBooks) {
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(10),
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              if (state is FailureHadistsBooks) {
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(10),
                  child: Text(state.message.toString()),
                );
              }

              if (state is SuccessHadistsBooks) {
                var data = state.result.data;
                return Container(
                  margin: EdgeInsets.all(10),
                  // color: Colors.blue,
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 5, right: 5),
                        width: MediaQuery.of(context).size.width / 3,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Constants.iwhite,
                          borderRadius: Constants
                              .cornerRadiusBox, //BorderRadius.circular(15),
                          boxShadow: [Constants.boxShadowMenuVersion3],
                        ),
                        child: ListTile(
                          title: Text(
                            data[index].name.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(data[index].available.toString()),
                        ),
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                  color: Constants.iFebruaryInk1,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Bukhari"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// {
// "maintaner": "Sutan Gading Fadhillah Nasution <sutan.gnst@gmail.com>",
// "source": "https://hadith-api-one.vercel.app//hadith-api",
// "endpoints": {
// "list": {
// "pattern": "https://api.hadith.sutanlab.id/books",
// "description": "Returns the list of available Hadith Books."
// },
// "hadith": {
// "pattern": "https://api.hadith.sutanlab.id/books/{name}?range={number}-{number}",
// "example": "https://api.hadith.sutanlab.id/books/muslim?range=1-150",
// "description": "Returns hadiths by range of number. (Note: For performance reasons, max accepted range: 300)"
// },
// "spesific": {
// "pattern": "https://api.hadith.sutanlab.id/books/{name}/{number}",
// "example": "https://api.hadith.sutanlab.id/books/bukhari/52",
// "description": "Returns spesific hadith."
// }
// }
// }
