import 'package:download_dialog_flutter/utils/cteate_path_directory.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  // https://www.youtube.com/watch?v=djzV9_pmK4g

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String downloadMessaging = "";
  bool _isDownloading = false;

  double percent = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("download progress"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //
            SizedBox(
              height: 50,
            ),
            FloatingActionButton.extended(
              onPressed: () async {
                if (await Permission.storage.request().isGranted) {
                  setState(() {
                    _isDownloading = !_isDownloading;
                    downloadMessaging = "Initializing...";
                    percent = 0;
                  });

                  var dir =
                      await CreateDirectory().createImageFolder(); // create


                  Dio dio = Dio();
                  dio.download(
                      "https://sample-videos.com/img/Sample-jpg-image-2mb.jpg",
                      "$dir/sample.jpg", // save image

                      onReceiveProgress: (actualbytes, totalbytes) {
                    var percentage = actualbytes / totalbytes * 100;

                    setState(() {
                      percent = percentage;
                      if (percentage.floor() == 100) {
                        downloadMessaging =
                            "Downloaded... ${percentage.floor()} %";
                      } else {
                        downloadMessaging =
                            "Downloading... ${percentage.floor()} %";
                      }
                    });
                  });
                }else{
                  print("no permission");
                }
              },
              label: Text("Download"),
              icon: Icon(Icons.file_download),
            ),

            SizedBox(
              height: 10,
            ),
            Text(downloadMessaging),
            SizedBox(
              height: 10,
            ),

            Slider(min: 0, max: 100, value: percent, onChanged: (value) {})
          ],
        ),
      ),
    );
  }
}
