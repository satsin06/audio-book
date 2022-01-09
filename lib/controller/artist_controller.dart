import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:audio_book/model/artist.dart';

class ArtistController {
  static Future<List<Artist>> getArtist() async {
    try {
      final response =
      await http.get(Uri.parse("https://run.mocky.io/v3/2abb5b4e-b46b-4b0d-a7ba-a20eb394782a"));
      if (response.statusCode == 200) {
        List<Artist> list = parseArtist(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Artist> parseArtist(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Artist>((json) => Artist.fromJson(json)).toList();
  }
}