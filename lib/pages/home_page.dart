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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Audio Book'),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder<List<Artist>>(
            future: getArtist(),
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
                        Artist artistData = data[index];
                        print(artistData.artworkUrl100);
                        return ExpansionTile(
                          title: Text(artistData.artistName),
                          children: [
                            ListTile(
                                leading: Image(
                              image: NetworkImage(artistData.artworkUrl100),
                            ),
                            title: Text(artistData.collectionName),
                            subtitle: Text(artistData.description),
                            )
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
