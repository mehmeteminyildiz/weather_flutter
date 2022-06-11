import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/Sayfalar/Detail.dart';
import 'package:project/Siniflar/Weather.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String cityName = "";
  double temp = 0;
  String description = "";
  String icon = "";

  Future<void> getSavedLocation() async {
    var sp = await SharedPreferences.getInstance();
    var saved_location = sp.getString("savedLocation") ?? "Ankara";
    setState(() {
      cityName = saved_location;
    });
    print("getSavedLocation");

    getLocationWeather();
  }

  Weather parseWeatherData(String response) {
    return Weather.fromJson(json.decode(response));
  }

  Future<void> getLocationWeather() async {
    print("getLocationWeather");
    var sp = await SharedPreferences.getInstance();
    var saved_location = sp.getString("savedLocation") ?? "No info";
    var saved_api_key = sp.getString("savedApiKey") ?? "No Api Key";

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$saved_location&appid=$saved_api_key&units=metric&lang=tr'));

    print(response.body);
    var data = parseWeatherData(response.body);

    setDatas(data);
  }

  void setDatas(Weather data) async {
    double _temp = data.temp;
    String _description = data.description;
    String _icon = data.icon.replaceAll('n', 'd');
    print("icon: ${data.icon}");

    setState(() {
      temp = _temp;
      description = _description;
      icon = _icon;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSavedLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Color.fromRGBO(0, 9, 66, 1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(
                    "${cityName.toUpperCase()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      letterSpacing: 7,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Text(
                    "${temp.round().toString()}°C",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Image.network(
                  "https://openweathermap.org/img/wn/$icon@4x.png",
                ),
                Text(
                  "${description.toUpperCase()}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detail(cityName: cityName)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Detayları Göster",
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
