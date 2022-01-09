import 'dart:convert';

import 'package:http/http.dart' as http;

class Artist {
  final int artistId;
  final int collectionId;
  final String artistName;

  Artist({
    required this.artistId,
    required this.collectionId,
    required this.artistName,
  });

  // Return object from JSON //
  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      artistId: json['artistId'],
      collectionId: json['collectionId'],
      artistName: json['artistName'],
    );
  }
}

Future<List<Artist>> fetchArtist() async {
  final response = await http.get(Uri.parse(
      'https://run.mocky.io/v3/2abb5b4e-b46b-4b0d-a7ba-a20eb394782a'));
  print(response.statusCode);
  if (response.statusCode == 200) {
    Map jsonResponse = json.decode(response.body);
    return jsonResponse['results'].map<Artist>((data) => Artist.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load list');
  }
}
