import 'package:firebase/Register.dart';
import 'package:firebase/Services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyhomePage(),
    );
  }
}

class MyhomePage extends StatelessWidget {
  final ucontroller = TextEditingController();
  final pcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Personal info'),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.yellow,
            image: DecorationImage(
                image: AssetImage(
                  'lib/download.jpg',
                ),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.white, fontSize: 20),
              ),
              controller: ucontroller,
            ),
            TextField(
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              controller: pcontroller,
            ),
            RaisedButton(
              child: Text('Login'),
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: ucontroller.text, password: pcontroller.text);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                } catch (e) {
                  print('error SI');
                }
              },
            ),
            RaisedButton(
              child: Text('Register'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Register()));
              },
            )
          ],
        ),
      ),
    );
  }
}
