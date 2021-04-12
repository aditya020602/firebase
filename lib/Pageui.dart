import 'dart:io';
import 'package:geocoder/geocoder.dart';

import './Gallery.dart';
import 'package:firebase/Gallery.dart';
import 'package:firebase/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import 'Profile.dart';
import 'Services.dart';

class Pageui extends StatefulWidget {
  final snapshot;

  Pageui(this.snapshot);

  @override
  _PageuiState createState() => _PageuiState();
}

class _PageuiState extends State<Pageui> {
  File pickedimage;
  var durl;
  var photourl;
  signout(ctx) {
    FirebaseAuth.instance.signOut();
    Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => MyApp()));
  }

  addimage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    print(image);

    var task = await FirebaseStorage.instance
        .ref()
        .child('image')
        .putFile(File(image.path));
    var ref = FirebaseStorage.instance.ref().child('image');
    var durl = await task.ref.getDownloadURL();
    Services().UpdateProfilePic(durl).then((val) {
      setState(() {});
    });
  }

  getLocation() async {
    var mylocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
    );
    var coordinates = Coordinates(mylocation.latitude, mylocation.longitude);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = address.first;
    print(first.addressLine);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              Text(first.addressLine),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Done')),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    Navigator.pop(context);
                    getLocation();
                  },
                  child: Text('refresh'))
            ],
          );
        });
    print(mylocation);
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    photourl = widget.snapshot.data.data()['url'];
    print(photourl);
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
            color: Colors.yellow,
            image: DecorationImage(
                image: AssetImage(
                  'lib/download.jpg',
                ),
                fit: BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (photourl == 'https://picsum.photos/200/300')
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Text(''),
              ),
            if (photourl == 'https://picsum.photos/200/300')
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 20),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: addimage,
                        child: Text('Add profile image')),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Profile()));
                      },
                      child: Text('Refresh Image'))
                ],
              ),
            if (photourl != 'https://picsum.photos/200/300')
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    color: Colors.black,
                    child: Image.network(photourl),
                  ),
                  SingleChildScrollView(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 20),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                              onPressed: addimage,
                              child: Text('Edit Image')),
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profile()));
                            },
                            child: Text('Refresh Image'))
                      ],
                    ),
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                child: Text(
                  'Name: ${widget.snapshot.data.data()['name']}',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                child: Text(
                    'Email address: ${widget.snapshot.data.data()['email']}',
                    style: TextStyle(fontSize: 25, color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                child: Text(
                    'Hobbies: ${widget.snapshot.data.data()['hobbies']}',
                    style: TextStyle(fontSize: 25, color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    signout(context);
                  },
                  child: Text('Sign out')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: getLocation,
                  child: Text('My location')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Gallery()));
                  },
                  child: Text('Gallery')),
            )
          ],
        ),
      ),
    );
  }
}
