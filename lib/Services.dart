import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Services {
  final name;
  final hobbies;
  Services({this.name, this.hobbies});
  storeuserdata(user, context) async {
    await FirebaseFirestore.instance.collection('/user').doc(user.uid).set({
      'email': user.email,
      'uid': user.uid,
      'hobbies': hobbies,
      'name': name,
      'url': 'https://picsum.photos/200/300'
    });

    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
  }

  UpdateProfilePic(url) async {
    var value =
        await FirebaseAuth.instance.currentUser.updateProfile(photoURL: url);
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user.uid)
        .update({'url': url});
  }
}
