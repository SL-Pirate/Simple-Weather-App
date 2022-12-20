import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:simple_weather_app/weather.dart';
import 'package:simple_weather_app/http_error.dart';

class RestApiSrvc{
  static const String _apiKey = '857da17a4a663a880b6369b38ecd6501';
  String units = "metric";

  Future<Weather> callApi(String city) async{
    String reqLink = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=${_getApiKey()}&units=$units";
    final response = await http.get(Uri.parse(reqLink));

    if(response.statusCode != 200){
      throw HttpError(json.decode(response.body));
    }

    Map<String, dynamic> result = json.decode(response.body);
    return Weather(result, city);
  }

  String _getApiKey(){
    return _apiKey;
  }
}