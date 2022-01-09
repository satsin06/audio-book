import 'dart:async';

import 'package:audio_book/controller/shimmer_about.dart';
import 'package:audio_book/model/artist.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  late Future<List<Artist>> futureArtist;
  @override
  void initState() {
    super.initState();
    futureArtist = fetchArtist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Audio Book'),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder<List<Artist>>(
            future: futureArtist,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const ShimmerEffect();
              }
              if (snapshot.hasData) {
                List<Artist>? data = snapshot.data;
                print(data);
                return Expanded(
                  child: ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                            title: Text(data[index].artistName),
                            children: [
                              Text('Check')
                            ],
                            );
                      }),
                );
              }
              return Text('${snapshot.error}');
            },
          ),
        ));
  }
}
