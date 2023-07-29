import 'package:flutter/material.dart';
import 'package:rajoongan/app/components/button/back_button_map.dart';

import 'history_detail.dart';
import 'history_form.dart';

class BaseViewTravelHistory extends StatefulWidget {
  String show;
  Map listRiwayatPerjalanan;
  int idx;
  BaseViewTravelHistory({
    super.key,
    required this.show,
    required this.listRiwayatPerjalanan,
    this.idx = 1,
  });

  @override
  State<BaseViewTravelHistory> createState() => _BaseViewTravelHistoryState();
}

class _BaseViewTravelHistoryState extends State<BaseViewTravelHistory> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: widget.show.contains("Form")
              ? FormPageTravelHistory(
                  listRiwayatPerjalanan: widget.listRiwayatPerjalanan,
                )
              : HistoryTravelDetail(
                  idx: widget.idx,
                  listRiwayatPerjalanan: widget.listRiwayatPerjalanan,
                ),
        ),
        const BackButtonOnMap(),
      ],
    );
  }
}
