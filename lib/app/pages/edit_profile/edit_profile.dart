import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

import 'package:rajoongan/app/components/button/finalstate_button.dart';
import 'package:rajoongan/app/components/title/page_title.dart';
import 'package:rajoongan/app/constants/color.dart';
import 'package:rajoongan/app/modules/home/views/home_view.dart';

class PageEditProfile extends StatefulWidget {
  PageEditProfile({
    super.key,
    required this.nama,
    required this.namaKapal,
    required this.jenisMesin,
    required this.kecepatanDinas,
    required this.kelompokNelayan,
    required this.horsePower,
    required this.uid,
    required this.imageUrl,
  });
  final String nama,
      namaKapal,
      jenisMesin,
      horsePower,
      kecepatanDinas,
      kelompokNelayan;

  final String uid;
  String? imageUrl;

  @override
  State<PageEditProfile> createState() => _PageEditProfileState();
}

class _PageEditProfileState extends State<PageEditProfile> {
  List<String> listLabelText = [
    'Nama',
    'Nama Kapal',
    'Jenis Mesin',
    'Daya Mesin',
    'Kecepatan Dinas',
    'Kelompok Nelayan'
  ];

  final List<TextEditingController> _listTextEditingController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  Future<void> updateProfile() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .update(
        {
          'nama': _listTextEditingController[0].text,
          'namaKapal': _listTextEditingController[1].text,
          'jenisMesin': _listTextEditingController[2].text,
          'horsePower': _listTextEditingController[3].text,
          'kecepatanDinas': _listTextEditingController[4].text,
          'kelompokNelayan': _listTextEditingController[5].text,
        },
      );

      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
        );
      });
    } on FirebaseException catch (e) {
      final snackBar = SnackBar(
        content: Text(e.code),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blueGrey,
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void setData() {
    _listTextEditingController[0].text = widget.nama;
    _listTextEditingController[1].text = widget.namaKapal;
    _listTextEditingController[2].text = widget.jenisMesin;
    _listTextEditingController[3].text = widget.horsePower;
    _listTextEditingController[4].text = widget.kecepatanDinas;
    _listTextEditingController[5].text = widget.kelompokNelayan;
  }

  final ImagePicker imagePicker = ImagePicker();

  Future _selectPhoto() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        onClosing: () {},
        builder: (context) => Column(
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.filter),
              title: const Text('Pick an image'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            )
          ],
        ),
      ),
    );
  }

  Future _pickImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (pickedFile == null) return;

    var file = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    if (file == null) return;

    await _uploadFile(file.path);
  }

  dynamic ref;
  Future _uploadFile(String path) async {
    final res = await ref.putFile(File(path));
    final fileUrl = await res.ref.getDownloadURL();

    setState(() {
      widget.imageUrl = fileUrl;
    });
  }

  @override
  void initState() {
    setData();
    ref = storage.FirebaseStorage.instance
        .ref()
        .child("images")
        .child(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PageTitle(
                  title1: "Profil Akun",
                  title2: "Edit informasi seputar akun anda",
                ),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: lightBlue,
                          width: 3,
                        ),
                      ),
                      padding: const EdgeInsets.all(3),
                      child: CircleAvatar(
                        radius: 56,
                        backgroundImage: NetworkImage(
                          widget.imageUrl == null
                              ? 'https://png.pngitem.com/pimgs/s/421-4212266_transparent-default-avatar-png-default-avatar-images-png.png'
                              : widget.imageUrl!,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 70,
                      child: GestureDetector(
                        onTap: _selectPhoto,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 3),
                                blurRadius: 8,
                              )
                            ],
                          ),
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: _listTextEditingController.length,
                  itemBuilder: (BuildContext context, int idx) {
                    return EditProfileTextField(
                      textEditingController: _listTextEditingController[idx],
                      labelText: listLabelText[idx],
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                FinalstateButton(
                  onpress: () {
                    updateProfile();
                  },
                  text: 'Simpan',
                  verticalPadding: 12,
                  horizontalPadding: 70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditProfileTextField extends StatelessWidget {
  const EditProfileTextField({
    super.key,
    required TextEditingController textEditingController,
    required this.labelText,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black45),
          ),
          onSubmitted: (value) {
            _textEditingController.text = _textEditingController.text;
          },
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
