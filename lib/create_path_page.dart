import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CreatePath extends StatefulWidget {
  const CreatePath({Key? key}) : super(key: key);

  @override
  _CreatePathState createState() => _CreatePathState();
}

class _CreatePathState extends State<CreatePath> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("create direction path"),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
              child: Text("create dir path"),
              onPressed: () async {
                if (await Permission.storage.request().isGranted) {
                  createMyFolder();
                } else {
                  print("no permission");
                }
              }),
        ),
      ),
    );
  }
}



void createMyFolder() async {

  Directory directory;
  try{
    if (await Permission.storage.request().isGranted) {
      directory = Directory('/storage/emulated/0/MyFolder/music');

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        int a = 5;
      }
    }

  }catch (e) {
    print(e);
  }
}

