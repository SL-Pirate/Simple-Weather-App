import 'dart:convert';

import 'package:intl/intl.dart';

class Weather {
  String? city;
  String? status;
  num? temp;
  num? feel_like;
  num? temp_min;
  num? temp_max;
  num? pressure;
  num? humidity;
  String? wind_speedS;
  num? wind_speed;

  Weather(Map<String, dynamic> json) {
    city = json['name'] ?? "City name not found";
    status = json['weather'][0]['description'];
    Map<String, dynamic> tmp = json['main'];
    temp = tmp['temp'];
    feel_like = tmp['feels_like'];
    temp_max = tmp['temp_max'];
    temp_min = tmp['temp_min'];
    pressure = tmp['pressure'];
    humidity = tmp['humidity'];

    NumberFormat fmt = NumberFormat('.0#', "en_US");
    wind_speed = json['wind']['speed'] * 60 * 60 / 1000;
    wind_speedS = fmt.format(wind_speed);
  }

  String getWeather() {
    return "\t\t\t__${city!.toUpperCase()}__\n\n$status\nTemperature is ${temp}C\u00B0 \nfeels like: ${feel_like}C\u00B0 \nTemperature range: ${temp_min}C\u00B0 - ${temp_max}C\u00B0 \nPressure: $pressure hPa\nHumidity: $humidity%\nWind speed: $wind_speedS km h\u207B\u00B9";
  }
}

class WeatherErr extends Weather {
  static final Map<String, dynamic> tmpResponse = jsonDecode(
      '{"coord":{"lon":80.6356,"lat":7.2955},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"base":"stations","main":{"temp":26.79,"feels_like":28.22,"temp_min":26.79,"temp_max":26.79,"pressure":1006,"humidity":66,"sea_level":1006,"grnd_level":949},"visibility":10000,"wind":{"speed":2.31,"deg":55,"gust":3.51},"clouds":{"all":94},"dt":1671525847,"sys":{"country":"LK","sunrise":1671497035,"sunset":1671539147},"timezone":19800,"id":1241622,"name":"Kandy","cod":200}');

  WeatherErr() : super(tmpResponse);

  @override
  String getWeather() {
    return "API key for openweathermap.org not found or invalid.\nPlease edit the 'ApiKey' file \nfill in your API key and recompile";
  }
}
