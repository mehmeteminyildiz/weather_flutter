import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Change extends StatefulWidget {
  const Change({Key? key}) : super(key: key);

  @override
  State<Change> createState() => _ChangeState();
}

class _ChangeState extends State<Change> {
  late String savedLocation = "";

  Future<void> getSavedLocation() async {
    var sp = await SharedPreferences.getInstance();
    savedLocation = sp.getString("savedLocation") ?? "No info";
    setState(() {});
  }

  Future<void> saveLocation(String newLocation) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString("savedLocation", newLocation);
    setState(() {
      savedLocation = newLocation;
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("New city saved")));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSavedLocation();
  }

  @override
  Widget build(BuildContext context) {
    var tfController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Container(
          color: Color.fromRGBO(0, 9, 66, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Kayıtlı Şehir: $savedLocation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
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
                      "Şehrini gir",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: OutlinedButton(
                  onPressed: () {
                    saveLocation(tfController.text.trim());
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
    );
  }
}
