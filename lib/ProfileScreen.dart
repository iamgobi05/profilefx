import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProfileScreen());
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void initState() {
    super.initState();
    getData();
  }

  String images = "";
  String number1 = "";
  String text1 = "";
  Future<void> getData() async {
    var getData = await FirebaseFirestore.instance
        .collection("profilefx")
        .doc("profilefx")
        .get();
    images = getData['image'];
    number1 = getData["number"];
    text1   = getData["text"];
  }

  double screenHeight = 0;
  double screenWidth = 0;
  String profilePicLink = "";

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,

      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    Reference ref = FirebaseStorage.instance.ref().child("profilepic.jpg");

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
      });
    });
  }

  TextEditingController _textEditingController = TextEditingController(
  );
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                pickUploadProfilePic();
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(115, 30, 110, 0),
                height: 120,
                width: 120,
                alignment: Alignment.center,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    profilePicLink,
                  ),
                  backgroundColor: Colors.grey,
                  radius: 60,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Edit",
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "BUSINESS NAME",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                SizedBox(
                  height: 55,
                  child: TextField(


                    decoration: InputDecoration(
                      hintText: "Business name",
                      border: OutlineInputBorder(
                      ),

                    ),

                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "PHONE NUMBER",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 55,
                  child: TextField(
                    onChanged: (text) {
                      FirebaseFirestore.instance.collection("profilefx").doc("profilefx").set({"number": _nameController.text});
                    },

                    controller: _nameController,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "BUSINESS DESCRIPTION",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 55,
                  child: TextField(
                    onChanged: (text) {
                      FirebaseFirestore.instance.collection("profilefx").doc("profilefx").set({"text": _textEditingController.text});
                    },
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
