import 'package:flutter/material.dart';
import 'package:project/Sayfalar/Change.dart';
import 'package:project/Sayfalar/Home.dart';
import 'package:project/Sayfalar/Settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var pageList = [Home(), Change(), Settings()];
  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(26, 36, 100, 1),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Colors.white),
            label: 'Anasayfa',
            activeIcon: Icon(Icons.home, color: Colors.white),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.edit, color: Colors.white),
            icon: Icon(Icons.edit_outlined, color: Colors.white),
            label: 'Düzenle',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined, color: Colors.white),
            activeIcon: Icon(Icons.settings, color: Colors.white),
            label: 'Ayarlar',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        onTap: onItemTapped,
      ),
    );
  }
}
