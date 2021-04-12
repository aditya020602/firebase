import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List imagelist = [];
  var list;
  multiimage() async {
    var list = await MultiImagePicker.pickImages(maxImages: 30);
    setState(() {
      imagelist = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: multiimage,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: imagelist.isEmpty
          ? Column(
              children: [
                Center(
                  child: Text('add images'),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: List.generate(imagelist.length, (index) {
                      return AssetThumb(
                          asset: imagelist[index], width: 400, height: 400);
                    }),
                  ),
                ],
              ),
            ),
    );
  }
}
