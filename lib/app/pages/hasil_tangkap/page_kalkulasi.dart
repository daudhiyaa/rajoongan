import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rajoongan/app/components/button/finalstate_button.dart';

import 'package:rajoongan/app/components/container/rounded_container.dart';
import 'package:rajoongan/app/components/container/value_unit_container.dart';
import 'package:rajoongan/app/components/text-field/rounded_input_field_without_icon.dart';
import 'package:rajoongan/app/components/title/page_title.dart';
import 'package:rajoongan/app/constants/color.dart';
import 'package:rajoongan/app/models/money_converter.dart';
import 'package:rajoongan/app/modules/home/views/home_view.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class KalkulasiHasilTangkapPage extends StatefulWidget {
  final double totalBerat, totalHarga;
  final List allNamaTangkapan;
  final String tanggal;
  final int idx;

  const KalkulasiHasilTangkapPage({
    super.key,
    required this.totalBerat,
    required this.totalHarga,
    required this.allNamaTangkapan,
    required this.tanggal,
    this.idx = -1,
  });

  @override
  State<KalkulasiHasilTangkapPage> createState() =>
      _KalkulasiHasilTangkapPageState();
}

class _KalkulasiHasilTangkapPageState extends State<KalkulasiHasilTangkapPage> {
  final TextEditingController totalHargaBahanBakarController =
      TextEditingController();

  double totalKeuntungan = 0;
  void calculateKeuntungan(double totalHargaTangkapan) {
    totalKeuntungan =
        totalHargaTangkapan - double.parse(totalHargaBahanBakarController.text);
    setState(() {});
  }

  Map listTangkapan = {};
  int totalTangkapan = 0;

  User? user;
  String uid = '';

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    uid = user!.uid;
    super.initState();
  }

  Future<void> addValueToListTangkapan() async {
    listTangkapan['tangkapan-${widget.idx + 1}'] = {
      'tanggal': widget.tanggal,
      'tangkapan': widget.allNamaTangkapan,
      'totalBerat': widget.totalBerat,
      'totalKeuntungan': totalKeuntungan,
      'totalHarga': widget.totalHarga,
    };

    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'listTangkapan': listTangkapan,
        'totalTangkapan': widget.idx + 1,
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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(bottom: 40, top: 60),
        margin: const EdgeInsets.symmetric(horizontal: 37),
        // color: Colors.red,
        child: Column(
          children: [
            PageTitle(
              title1: "Hasil Tangkap",
              title2: "Hitung dan catat hasil tangkapan anda",
            ),
            const SizedBox(
              height: 10,
            ),
            const LabelField(
              title: 'Tanggal',
            ),
            RoundedContainer(
              verticalMargin: 5,
              borderRadius: 15,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  widget.tanggal,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const LabelField(
              title: 'Nama Nama Tangkapan',
            ),
            RoundedContainer(
              verticalMargin: 5,
              borderRadius: 15,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.allNamaTangkapan.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                      '${index + 1}. ${widget.allNamaTangkapan[index]}',
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const LabelField(
              title: 'Total Berat',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RoundedContainer(
                  verticalMargin: 5,
                  width: 0.66,
                  borderRadius: 15,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      '${widget.totalBerat}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const ValueUnitContainer(
                  value: 'Kg',
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const LabelField(
              title: 'Total Penjualan',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RoundedContainer(
                  verticalMargin: 5,
                  width: 0.66,
                  borderRadius: 15,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      convertNumberToMoney(
                        widget.totalHarga,
                        widget.totalHarga.abs(),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const ValueUnitContainer(
                  value: 'Rp',
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RoundedInputFieldWithoutIcon(
                  inputType: TextInputType.number,
                  textEditingController: totalHargaBahanBakarController,
                  width: 0.66,
                  fontSize: 15,
                  labelText: "Total Harga Bahan Bakar",
                  hintText: '',
                  onChanged: (value) {},
                ),
                const ValueUnitContainer(
                  value: 'Rp',
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            FinalstateButton(
              onpress: () {
                calculateKeuntungan(widget.totalHarga);
              },
              text: 'Kalkulasi',
              verticalPadding: 12,
              horizontalPadding: 70,
            ),
            const SizedBox(
              height: 20,
            ),
            const LabelField(
              title: 'Total Keuntungan',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RoundedContainer(
                  width: 0.66,
                  verticalMargin: 5,
                  borderRadius: 15,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      convertNumberToMoney(
                        totalKeuntungan,
                        totalKeuntungan.abs(),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const ValueUnitContainer(
                  value: 'Rp',
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            FinalstateButton(
              onpress: () {
                addValueToListTangkapan();
              },
              text: 'Simpan',
              verticalPadding: 12,
              horizontalPadding: 70,
            ),
          ],
        ),
      ),
    );
  }
}

class LabelField extends StatelessWidget {
  final String title;
  const LabelField({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(color: primaryColor),
      ),
    );
  }
}
