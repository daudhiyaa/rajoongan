import 'dart:io';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rajoongan/app/components/button/finalstate_button.dart';
import 'package:rajoongan/app/components/container/value_unit_container.dart';
import 'package:rajoongan/app/components/text-field/rounded_input_field_without_icon.dart';
import 'package:rajoongan/app/components/title/page_title.dart';
import 'package:rajoongan/app/modules/home/views/home_view.dart';

class FormPageTravelHistory extends StatefulWidget {
  Map listRiwayatPerjalanan;
  FormPageTravelHistory({
    Key? key,
    required this.listRiwayatPerjalanan,
  }) : super(key: key);

  @override
  State<FormPageTravelHistory> createState() => _FormPageTravelHistoryState();
}

class _FormPageTravelHistoryState extends State<FormPageTravelHistory> {
  final TextEditingController _date = TextEditingController();
  final TextEditingController namaFileController = TextEditingController();
  final TextEditingController totalJarakController = TextEditingController();
  final TextEditingController totalBBMController = TextEditingController();

  User? user;
  String uid = '';

  String? filePath;
  String namaFile = "";
  List<dynamic> dataFromFile = [];

  void pickFile() async {
    dataFromFile = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );

    if (result != null) {
      filePath = result.files.single.path!;
      List<String> words = filePath!.split('/');
      if (words.isNotEmpty) {
        namaFile = words.last;
        namaFileController.text = namaFile;
      }
      if (filePath != null) {
        File file = File(filePath!);
        Stream<List<int>> inputStream = file.openRead();
        final lines = await inputStream
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .toList();

        for (String line in lines) {
          dataFromFile.add(line);
        }
        print('datafromfile: $dataFromFile');
      }
    }
    setState(() {});
  }

  Map listRiwayatPerjalanan = {};
  late int idx;
  Future<void> addValueToListTangkapan() async {
    listRiwayatPerjalanan['riwayatPerjalanan-${idx + 1}'] = {
      'tanggal': _date.text,
      'totalJarak': totalJarakController.text,
      'totalBBM': totalBBMController.text,
      'listLatLng': dataFromFile,
    };

    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'listRiwayatPerjalanan': listRiwayatPerjalanan,
      }, SetOptions(merge: true));

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

  @override
  void initState() {
    super.initState();
    idx = widget.listRiwayatPerjalanan.length;
    namaFile = "Choose file";
    namaFileController.text = "-";
    user = FirebaseAuth.instance.currentUser;
    uid = user!.uid;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 40, top: 60),
      child: Column(
        children: [
          PageTitle(
            title1: "Riwayat Perjalanan",
            title2: "Rekam jejak rute yang telah anda lewati.",
          ),
          RoundedInputFieldWithoutIcon(
            textEditingController: _date,
            inputType: TextInputType.text,
            labelText: 'Tanggal',
            hintText: "Hari, Tanggal Bulan Tahun",
            onChanged: (value) {},
            fontSize: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedInputFieldWithoutIcon(
                textEditingController: namaFileController,
                inputType: TextInputType.none,
                width: 0.47,
                labelText: 'Nama File',
                hintText: "",
                onChanged: (value) {},
                fontSize: 15,
              ),
              const SizedBox(
                width: 17,
              ),
              FinalstateButton(
                onpress: pickFile,
                text: 'Pilih File',
                horizontalPadding: 25,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedInputFieldWithoutIcon(
                inputType: TextInputType.number,
                textEditingController: totalJarakController,
                width: 0.66,
                fontSize: 15,
                labelText: "Total Jarak",
                hintText: '',
                onChanged: (value) {},
              ),
              const ValueUnitContainer(value: 'Km'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedInputFieldWithoutIcon(
                inputType: TextInputType.number,
                textEditingController: totalBBMController,
                width: 0.66,
                fontSize: 15,
                labelText: "Total Bahan Bakar",
                hintText: '',
                onChanged: (value) {},
              ),
              const ValueUnitContainer(value: 'L'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FinalstateButton(
                onpress: () {
                  addValueToListTangkapan();
                },
                text: 'Simpan',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
