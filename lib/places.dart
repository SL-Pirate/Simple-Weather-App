import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlacesSrvc {
  final String _sessionToken;
  final String _apiKey = dotenv.get('placesApi');

  PlacesSrvc(this._sessionToken);

  Future<List<Suggestion>> fetchSuggestons(String query) async {
    if (query.isNotEmpty) {
      try {
        final String request =
            "https://maps.googleapis.com/maps/api/place/queryautocomplete/json?input=$query&types=address&language=en&components=country:sl&key=$_apiKey&sessiontoken=$_sessionToken";
        final response = await http.get(Uri.parse(request));

        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);
          if (result['status'] == "OK") {
            return result['predictions']
                .map<Suggestion>(
                    (p) => Suggestion(p['place_id'], p['description']))
                .toList();
          } else {
            return [];
          }
        } else {
          return [];
        }
      }
      catch(E){
        return [];
      }
    } else {
      return [];
    }
  }
}

class Suggestion {
  final String id;
  final String description;

  Suggestion(this.id, this.description);
}
