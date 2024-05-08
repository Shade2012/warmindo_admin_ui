import 'package:flutter/material.dart';

class UploadImage extends StatelessWidget {
  const UploadImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 412,
      height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight:  Radius.circular(10)),
      ),
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Camera'),
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Gallery'),
          ),
          ElevatedButton(onPressed: () {
            Navigator.pop(context);
          }, 
          child: Text('Kembali')
          ),
        ],
      ),
    );
  }
}