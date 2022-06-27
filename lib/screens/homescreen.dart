import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kita_muslim/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Constants.appName)),
      backgroundColor: Colors.green,
      body: GridView.count(
        primary: false,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(10),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.of(context).pushNamed('/bacaalquran'),
            child: Container(
              alignment: Alignment.center,
              child: Text("Baca Al-Qur'an"), //Text(myProducts[index]["name"]),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text("data"), //Text(myProducts[index]["name"]),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ],
      ),
    );
  }
}
