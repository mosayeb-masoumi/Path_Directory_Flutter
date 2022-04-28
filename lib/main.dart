
import 'package:download_dialog_flutter/create_path_page.dart';
import 'package:download_dialog_flutter/flutter_downloader.dart';
import 'package:download_dialog_flutter/dio_downloader_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';



Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true );// optional: set false to disable printing logs to console);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),

      home: FlutterDownloaderPage(),

    );
  }
}
