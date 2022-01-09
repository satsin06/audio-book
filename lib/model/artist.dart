import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
        description: json["description"]?.toString() ?? '',
      );
  Map<String, dynamic> toJson() => {
        "wrapperType": wrapperType,
        "artistId": artistId,
        "collectionId": collectionId,
        "artistName": artistName,
        "collectionName": collectionName,
        "collectionCensoredName": collectionCensoredName,
        "artistViewUrl": artistViewUrl,
        "collectionViewUrl": collectionViewUrl,
        "artworkUrl60": artworkUrl60,
        "artworkUrl100": artworkUrl100,
        "collectionPrice": collectionPrice,
        "collectionExplicitness": collectionExplicitness,
        "trackCount": trackCount,
        "copyright": copyright,
        "country": country,
        "currency": currency,
        "releaseDate": releaseDate.toIso8601String(),
        "primaryGenreName": primaryGenreName,
        "previewUrl": previewUrl,
        "description": description,
      };
}

Future<void> fetchArtist() async {
  final response = await http.get(Uri.parse(
      'https://run.mocky.io/v3/2abb5b4e-b46b-4b0d-a7ba-a20eb394782a'));
  print(response.statusCode);
  if (response.statusCode == 200) {
    Map jsonResponse = json.decode(response.body);
    List<String> artists = jsonResponse['results']
        .map<String>((data) => json.encode(data))
        .toList();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('artists', artists);
  } else {
    throw Exception('Failed to load list');
  }
}

Artist artistFromJson(String str) => Artist.fromJson(json.decode(str));

String artistToJson(Artist data) => json.encode(data.toJson());

Future<List<Artist>> getArtist() async {
  await fetchArtist();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final jsonList = prefs.getStringList('artists');
  List<Artist> artist = [];
  if (jsonList != null) {
    artist = jsonList.map((e) => artistFromJson(e)).toList();
  }
  return artist;
}
