import 'package:flutter/material.dart';
import 'package:rajoongan/app/components/button/back_button_map.dart';

import 'page_form.dart';
import 'page_kalkulasi.dart';

class BaseViewHasilTangkap extends StatefulWidget {
  String show, tanggal;
  final double totalBerat;
  final double totalHarga;
  final List allNamaTangkapan;
  final int idxPageKalkulasi;

  BaseViewHasilTangkap({
    super.key,
    required this.show,
    this.tanggal = 'Default',
    this.totalBerat = 0,
    this.totalHarga = 0,
    this.allNamaTangkapan = const [],
    this.idxPageKalkulasi = -1,
  });

  @override
  State<BaseViewHasilTangkap> createState() => _BaseViewHasilTangkapState();
}

class _BaseViewHasilTangkapState extends State<BaseViewHasilTangkap> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: widget.show == 'FormPage'
              ? FormPageHasilTangkap(
                  idx: widget.idxPageKalkulasi,
                )
              : KalkulasiHasilTangkapPage(
                  tanggal: widget.tanggal,
                  totalBerat: widget.totalBerat,
                  totalHarga: widget.totalHarga,
                  allNamaTangkapan: widget.allNamaTangkapan,
                  idx: widget.idxPageKalkulasi,
                ),
        ),
        const BackButtonOnMap(),
      ],
    );
  }
}
