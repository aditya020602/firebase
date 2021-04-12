import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './Profile.dart';
import 'Services.dart';

class Register extends StatelessWidget {
  final mcontroller = TextEditingController();
  final pwdcontroller = TextEditingController();
  final name = TextEditingController();
  final hobbies = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.black,
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
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                ),
                controller: name,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                  labelText: 'email',
                ),
                controller: mcontroller,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'password',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                ),
                controller: pwdcontroller,
                obscureText: true,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'hobbies',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                ),
                controller: hobbies,
              ),
              ElevatedButton(
                child: Text('Register'),
                onPressed: () async {
                  try {
                    var response = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: mcontroller.text,
                            password: pwdcontroller.text);

                    Services(name: name.text, hobbies: hobbies.text)
                        .storeuserdata(response.user, context);
                  } catch (e) {
                    print(e.message.toString());
                  }
                },
              )
            ],
          )),
    );
  }
}
