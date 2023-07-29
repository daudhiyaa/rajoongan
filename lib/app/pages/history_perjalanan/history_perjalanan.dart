import 'package:flutter/material.dart';
import 'package:rajoongan/app/components/button/back_button_map.dart';

import 'package:rajoongan/app/components/container/value_unit_container.dart';
import 'package:rajoongan/app/components/title/page_title.dart';
import 'package:rajoongan/app/constants/color.dart';
import 'package:rajoongan/app/pages/history_perjalanan/history_detail.dart';

import 'base_view.dart';

class HistoryPerjalanan extends StatefulWidget {
  Map listRiwayatPerjalanan;
  HistoryPerjalanan({
    super.key,
    required this.listRiwayatPerjalanan,
  });

  @override
  State<HistoryPerjalanan> createState() => _HistoryPerjalananState();
}

class _HistoryPerjalananState extends State<HistoryPerjalanan> {
  List<String> cardTitles = [];

  void setData(int len) {
    for (int i = 1; i <= len; i++) {
      cardTitles
          .add(widget.listRiwayatPerjalanan['riwayatPerjalanan-$i']['tanggal']);
      cardTitles.add(
          'Jarak : ${widget.listRiwayatPerjalanan['riwayatPerjalanan-$i']['totalJarak']} km');
      cardTitles.add(
          'Total BBM : ${widget.listRiwayatPerjalanan['riwayatPerjalanan-$i']['totalBBM']} L');
    }
  }

  @override
  void initState() {
    cardTitles = [];
    setData(widget.listRiwayatPerjalanan.length);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            actions: [
              Transform.scale(
                scale: 0.8,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4.5,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BaseViewTravelHistory(
                            show: "PageForm",
                            listRiwayatPerjalanan: widget.listRiwayatPerjalanan,
                          ),
                        ),
                      );
                    },
                    color: Colors.white,
                    iconSize: 20,
                    tooltip: 'Add',
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                PageTitle(
                  title1: "Riwayat Perjalanan",
                  title2: "Rekam jejak rute yang telah anda lewati.",
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  itemCount: widget.listRiwayatPerjalanan.length,
                  itemBuilder: (BuildContext context, int idx) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BaseViewTravelHistory(
                              show: "HistoryDetail",
                              idx: idx + 1,
                              listRiwayatPerjalanan:
                                  widget.listRiwayatPerjalanan,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Card(
                          color: lightBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 4,
                          child: Row(
                            children: [
                              ValueUnitContainer(value: '${idx + 1}'),
                              Expanded(
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List<Widget>.generate(
                                      3,
                                      (index) => Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                          top: 8.0,
                                        ),
                                        child: Text(
                                          cardTitles[index + (3 * idx)],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const BackButtonOnMap(),
      ],
    );
  }
}
