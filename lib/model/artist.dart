import 'dart:convert';

import 'package:http/http.dart' as http;

class Artist {
  Artist({
    required this.wrapperType,
    required this.artistId,
    required this.collectionId,
    required this.artistName,
    required this.collectionName,
    required this.collectionCensoredName,
    required this.artistViewUrl,
    required this.collectionViewUrl,
    required this.artworkUrl60,
    required this.artworkUrl100,
    required this.collectionPrice,
    required this.collectionExplicitness,
    required this.trackCount,
    required this.copyright,
    required this.country,
    required this.currency,
    required this.releaseDate,
    required this.primaryGenreName,
    required this.previewUrl,
    required this.description,
  });

  final String wrapperType;
  final int artistId;
  final int collectionId;
  final String artistName;
  final String collectionName;
  final String collectionCensoredName;
  final String artistViewUrl;
  final String collectionViewUrl;
  final String artworkUrl60;
  final String artworkUrl100;
  final double collectionPrice;
  final String collectionExplicitness;
  final int trackCount;
  final String copyright;
  final String country;
  final String currency;
  final DateTime releaseDate;
  final String primaryGenreName;
  final String previewUrl;
  final String description;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        wrapperType: json["wrapperType"].toString(),
        artistId: json["artistId"],
        collectionId: json["collectionId"],
        artistName: json["artistName"].toString(),
        collectionName: json["collectionName"].toString(),
        collectionCensoredName: json["collectionCensoredName"].toString(),
        artistViewUrl: json["artistViewUrl"].toString(),
        collectionViewUrl: json["collectionViewUrl"].toString(),
        artworkUrl60: json["artworkUrl60"].toString(),
        artworkUrl100: json["artworkUrl100"].toString(),
        collectionPrice: json["collectionPrice"].toDouble(),
        collectionExplicitness: json["collectionExplicitness"].toString(),
        trackCount: json["trackCount"],
        copyright: json["copyright"].toString(),
        country: json["country"].toString(),
        currency: json["currency"].toString(),
        releaseDate: DateTime.parse(json["releaseDate"]),
        primaryGenreName: json["primaryGenreName"].toString(),
        previewUrl: json["previewUrl"].toString(),
        description: json["description"]?.toString()?? '',
      );
}

Future<List<Artist>> fetchArtist() async {
  final response = await http.get(Uri.parse(
      'https://run.mocky.io/v3/2abb5b4e-b46b-4b0d-a7ba-a20eb394782a'));
  print(response.statusCode);
  if (response.statusCode == 200) {
    Map jsonResponse = json.decode(response.body);
    return jsonResponse['results']
        .map<Artist>((data) => Artist.fromJson(data))
        .toList();
  } else {
    throw Exception('Failed to load list');
  }
}
