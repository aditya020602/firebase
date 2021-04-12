import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Pageui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<DocumentSnapshot> getData() async {
    return await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.data() == null)
              return Center(child: Text(snapshot.data.data().toString()));
            else
              return Pageui(snapshot);
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Text("No data");
          } else
            return CircularProgressIndicator();
        },
      ),
    );
  }
}
