import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class CreateDirectory {
  Future<String> createMusicFolder() async {
    Directory directory = Directory('/storage/emulated/0/MyFolder/music');
    try {
      if (await Permission.storage.request().isGranted) {
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          int a = 5;
        }
      }
      return '/storage/emulated/0/MyFolder/music';
    } catch (e) {
      print(e);
      return '/storage/emulated/0/MyFolder/music';
    }
  }

  Future<String> createVideoFolder() async {
    Directory directory = Directory('/storage/emulated/0/MyFolder/video');
    try {
      if (await Permission.storage.request().isGranted) {
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          int a = 5;
        }
      }

      return "/storage/emulated/0/MyFolder/video";
    } catch (e) {
      print(e);

      return "/storage/emulated/0/MyFolder/video";
    }
  }

  Future<String> createImageFolder() async {
    Directory directory = Directory('/storage/emulated/0/MyFolder/image');
    try {
      if (await Permission.storage.request().isGranted) {
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          int a = 5;
        }
      }
      return "/storage/emulated/0/MyFolder/image";
    } catch (e) {
      print(e);
      return "/storage/emulated/0/MyFolder/image";
    }
  }
}
