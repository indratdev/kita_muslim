import 'package:flutter/material.dart';

class HadistScreen extends StatelessWidget {
  const HadistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hadist'),
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