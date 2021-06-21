import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:realchat/AuthConfig/start.dart';
import 'package:url_launcher/url_launcher.dart';

class Dashboard extends StatefulWidget {
  final String SchoolUpin;
  const Dashboard({Key key, this.SchoolUpin}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {



  String pathPDF = "";

  // int progress= 0;
  // ReceivePort receivePort =  ReceivePort();

  @override
  void initState() {
    /// this is related to download file
    // IsolateNameServer.registerPortWithName(receivePort.sendPort, "Downloading File");
    // receivePort.listen((message) {
    //   setState(() {
    //     progress = message;
    //   });
    // });
    // FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
   /* createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });*/
  }

  Future<File> createFileOfPdfUrl() async {
    final url = "";
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  /// this for download
  // void _downloadFile() async{
  //   final status = await Permission.storage.request();
  //   if(status.isGranted){
  //
  //     final baseStorage =  await getExternalStorageDirectory();
  //     final id = await FlutterDownloader.enqueue(
  //         url: "https://www.cdc.gov/coronavirus/2019-ncov/downloads/2019-ncov-factsheet.pdf",
  //         savedDir: baseStorage.path,
  //         fileName: 'Download File'
  //     );
  //
  //
  //   }else{
  //     print("Permission Denied");
  //   }
  // }
  // static downloadCallback(id, status, progress){
  //   SendPort sendPort = IsolateNameServer.lookupPortByName("Downloading File");
  //   sendPort.send(progress);
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('pdf')),
      body: Container(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                child: Text("Open PDF"),
                onPressed: ()  {
                   launch(
                      "http://www.africau.edu/images/default/sample.pdf",
                  );
                },
              ),
            ),
            /// below i comment out this all for download please try to do this. if possible
            // ElevatedButton(
            //   child: Text("Download file"),
            //   onPressed: _downloadFile,
            // ),
            // Text(
            //     '$progress'
            // ),
            // Text(
            //     'Download processing'
            // )
          ],
        ),

      ),
    );
  }
}

class PDFScreen extends StatelessWidget {
  String pathPDF = "";
  PDFScreen(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return  PDFViewerScaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.blueGrey,
          title: Text("PDF Document"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        path: pathPDF
    );
  }
}
