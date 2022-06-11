import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _savedApiKey = "";

  Future<void> saveNewApiKey(String newApiKey) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString("savedApiKey", newApiKey);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Yeni API Key kaydedildi")));

    setState(() {
      _savedApiKey = newApiKey;
    });
  }

  Future<void> getSavedApiKey() async {
    var sp = await SharedPreferences.getInstance();
    var saved_api_key = sp.getString("savedApiKey") ?? "No Api Key";

    setState(() {
      _savedApiKey = saved_api_key;
    });
    print("Your api key: $_savedApiKey");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSavedApiKey();
  }

  @override
  Widget build(BuildContext context) {
    var tfController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Container(
          color: Color.fromRGBO(0, 9, 66, 1),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Weather App",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Bu uygulama, OpenWeatherMap web sitesinin API'sini kullanır. Her API anahtarı için günlük istek sınırı vardır."
                    " API Anahtarı sınırınıza ulaşılırsa, aşağıdaki alandan yeni API Anahtarınızı girebilirsiniz.\n\n"
                    "Weather App Nasıl Kullanılır\n"
                    "Varsayılan olarak Ankara şehri seçilidir. Düzenle sayfasından şehir tercihinizi"
                    " değiştirebilirsiniz.",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Kullanılan Api Key:\n$_savedApiKey",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: tfController,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 4.0),
                        ),
                        label: Text(
                          "API Key giriniz",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: OutlinedButton(
                      onPressed: () {
                        saveNewApiKey(tfController.text.trim());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Kaydet",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Color.fromRGBO(0, 9, 66, 1),
                        elevation: 10,
                        side: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
