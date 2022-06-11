import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'package:project/Sayfalar/Detail.dart';
import 'package:project/Siniflar/Weather.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detail extends StatefulWidget {
  String cityName;

  Detail({required this.cityName});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String description = "";
  double temp = 0.0;
  double feels_like = 0;
  double temp_min = 0, temp_max = 0;
  int pressure = 0, humidity = 0;
  double wind_speed = 0;
  String icon = "";

  Weather parseWeatherData(String response) {
    return Weather.fromJson(json.decode(response));
  }

  Future<void> getLocationWeather() async {
    print("getLocationWeather");
    var sp = await SharedPreferences.getInstance();
    var saved_location = widget.cityName;
    var saved_api_key = sp.getString("savedApiKey") ?? "No Api Key";

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$saved_location&appid=$saved_api_key&units=metric&lang=tr'));

    print(response.body);
    var data = parseWeatherData(response.body);

    setDatas(data);
  }

  void setDatas(Weather data) {
    description = data.description.toUpperCase();
    temp = data.temp;
    feels_like = data.feels_like;
    temp_min = data.temp_min;
    temp_max = data.temp_max;
    pressure = data.pressure;
    humidity = data.humidity;
    wind_speed = data.wind_speed;
    icon = data.icon.replaceAll('n', 'd');

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationWeather();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Color.fromRGBO(0, 9, 66, 1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50.0,
                  ),
                  child: Text(
                    "${widget.cityName}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                Text(
                  "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50.0,
                  ),
                  child: Text(
                    "Günlük Hava Tahmini",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
                Image.network(
                  "https://openweathermap.org/img/wn/$icon@4x.png",
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Text(
                    "${description}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      primary: false,
                      crossAxisCount: 3,
                      childAspectRatio: 2 / 1.5,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sıcaklık",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                "${temp}°",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Rüzgar",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                "${wind_speed} km/h",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Nem",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                "${humidity}%",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Hissedilen",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                "${feels_like}°",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Min",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                "${temp_min}°",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Max",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                "${temp_max}°",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Text("Temp: $temp"),
                // Text("$description"),
                // Text("Feels Like: $feels_like"),
                // Text("Min: $temp_min"),
                // Text("Max: $temp_max"),
                // Text("Pressure: $pressure"),
                // Text("Humidity: $humidity"),
                // Text("Wind Speed: $wind_speed"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
