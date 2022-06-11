import 'dart:ffi';

class Weather {
  String description;
  String icon; // maybe
  double temp;
  double feels_like;
  double temp_min;
  double temp_max;
  int pressure;
  int humidity;
  double wind_speed;

  Weather(
    this.description,
    this.icon,
    this.temp,
    this.feels_like,
    this.temp_min,
    this.temp_max,
    this.pressure,
    this.humidity,
    this.wind_speed,
  );

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      json["weather"][0]["description"] as String,
      json["weather"][0]["icon"] as String,
      json["main"]["temp"] + .0 as double,
      json["main"]["feels_like"] + .0 as double,
      json["main"]["temp_min"] + .0 as double,
      json["main"]["temp_max"] + .0 as double,
      json["main"]["pressure"] as int,
      json["main"]["humidity"] as int,
      json["wind"]["speed"] + .0 as double,
    );
  }
}
