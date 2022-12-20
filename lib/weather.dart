import 'package:intl/intl.dart';

class Weather{
  final String city;
  String? status;
  num? temp;
  num? feel_like;
  num? temp_min;
  num? temp_max;
  num? pressure;
  num? humidity;
  String? wind_speedS;
  num? wind_speed;

  Weather(Map<String, dynamic> json, this.city){
    status = json['weather'][0]['description'];
    Map<String, dynamic> tmp = json['main'];
    temp = tmp['temp'];
    feel_like = tmp['feels_like'];
    temp_max = tmp['temp_max'];
    temp_min = tmp['temp_min'];
    pressure = tmp['pressure'];
    humidity = tmp['humidity'];

    NumberFormat fmt = NumberFormat('.0#', "en_US");
    wind_speed = json['wind']['speed']*60*60/1000;
    wind_speedS = fmt.format(wind_speed);
  }

  String getWeather(){

    return "\t\t\t__${city.toUpperCase()}__\n\n${status}\nTemperature is ${temp}C\u00B0 \nfeels like: ${feel_like}C\u00B0 \nTemperature range: ${temp_min}C\u00B0 - ${temp_max}C\u00B0 \nPressure: ${pressure} hPa\nHumidity: ${humidity}%\nWind speed: ${wind_speedS} km h\u207B\u00B9";
  }
}