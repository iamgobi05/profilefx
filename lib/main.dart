import 'package:flutter/material.dart';
import 'package:profilefx/ProfileScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Text("Edit profile"),
            centerTitle: true,
          ),
          body: ProfileScreen(),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.stop_circle),
                label: "Status",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.call_sharp),
                label: "Calls",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt_rounded),
                label: "Camera",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wechat_sharp),
                label: "Chats",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_applications_outlined),
                label: "Settings",
              ),
            ],
          ),
        ),
      ),

    );
  }
}
