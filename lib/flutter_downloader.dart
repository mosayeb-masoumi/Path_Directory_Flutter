import 'dart:io';
import 'dart:isolate';
import 'dart:ui';


import 'package:download_dialog_flutter/create_path_page.dart';
import 'package:download_dialog_flutter/utils/cteate_path_directory.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';



class FlutterDownloaderPage extends StatefulWidget {
  const FlutterDownloaderPage({Key? key}) : super(key: key);


  // https://www.youtube.com/watch?v=4xJtsZU0o40

  @override
  _FlutterDownloaderPageState createState() => _FlutterDownloaderPageState();
}

class _FlutterDownloaderPageState extends State<FlutterDownloaderPage> {


  Future download(String url, String path ) async{

   await FlutterDownloader.enqueue(
      url: url,
      savedDir: path,
      saveInPublicStorage: true,
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );

  }

  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];


      if(status ==DownloadTaskStatus.complete){
        print("Download Complete");
      }

      setState((){ });
    });





    FlutterDownloader.registerCallback(downloadCallback);
  }


  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }


  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }













  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter downloader"),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(

            child: Text("download"),
              onPressed: () async {





            if (await Permission.storage.request().isGranted) {

              String path = await CreateDirectory().createVideoFolder();
              String url = "https://download.samplelib.com/mp4/sample-5s.mp4";
              // String url = "https://download.samplelib.com/mp4/sample-10s.mp4";
              // final baseStorage = await getExternalStorageDirectory();



              download(url , path);

              // setState(() async {
              //
              //
              //
              // });

              
            }
          }),
        ),
      ),
    );
  }


}
