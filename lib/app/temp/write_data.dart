import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class WriteDataPage extends StatefulWidget {
  const WriteDataPage({super.key});

  @override
  State<WriteDataPage> createState() => _WriteDataPageState();
}

class _WriteDataPageState extends State<WriteDataPage> {
  String image = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            image.isEmpty
                ? const SizedBox()
                : Image.file(
                    File(image),
                  ),
            ElevatedButton(
              onPressed: () async {
                var status = await Permission.storage.request();
                if (status == PermissionStatus.granted) {
                  var image = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    setState(() {
                      this.image = image.path;
                    });
                  }
                }
              },
              child: const Text("Select Image"),
            ),
            ElevatedButton(
              onPressed: () async {
                var status = await Permission.storage.request();
                if (status == PermissionStatus.granted) {
                  var read = await File(image).readAsBytes();
                  var newfile = await File(
                    '/storage/emulated/0/Download/filename.png',
                  ).create(recursive: true);
                  await newfile.writeAsBytes(read);
                }
              },
              child: const Text("Create file and write it as asbpve"),
            ),
            ElevatedButton(
              onPressed: () async {
                // Directory? appDocDirectory =
                //     await getExternalStorageDirectory();
                // print(appDocDirectory);

                var isFileExist = await File(
                  '/storage/emulated/0/Download/filename.png',
                ).exists();
                if (isFileExist) {
                  File(
                    '/storage/emulated/0/Download/filename.png',
                  ).delete(recursive: true);
                }
              },
              child: const Text("Delete file"),
            ),
            ElevatedButton(
              onPressed: () async {
                var file = File(image);
                print(await file.lastAccessed());
                print(file.statSync());
              },
              child: const Text("Get File Data"),
            ),
            ElevatedButton(
              onPressed: () async {
                var f = File(
                  '/storage/emulated/0/Download/filename.png',
                );
                f.rename('/storage/emulated/0/Download/yaaa.png');
              },
              child: const Text("Rename File"),
            )
          ],
        ),
      ),
    );
  }
}
