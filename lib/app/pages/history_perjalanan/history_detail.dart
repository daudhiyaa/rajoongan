import 'package:flutter/material.dart';
import 'package:rajoongan/app/components/button/finalstate_button.dart';
import 'package:rajoongan/app/components/container/rounded_container.dart';
import 'package:rajoongan/app/components/title/page_title.dart';

import 'history_map.dart';

class HistoryTravelDetail extends StatefulWidget {
  Map listRiwayatPerjalanan;
  int idx;

  HistoryTravelDetail({
    super.key,
    required this.listRiwayatPerjalanan,
    required this.idx,
  });

  @override
  State<HistoryTravelDetail> createState() => _HistoryTravelDetailState();
}

class _HistoryTravelDetailState extends State<HistoryTravelDetail> {
  List<dynamic> listLatLng = [];
  String tanggal = "", totalBBM = "", totalJarak = "";

  @override
  void initState() {
    super.initState();

    List<dynamic> listTemporary = [];
    listTemporary = widget
        .listRiwayatPerjalanan['riwayatPerjalanan-${widget.idx}']['listLatLng'];
    tanggal = widget.listRiwayatPerjalanan['riwayatPerjalanan-${widget.idx}']
        ['tanggal'];
    totalBBM = widget.listRiwayatPerjalanan['riwayatPerjalanan-${widget.idx}']
        ['totalBBM'];
    totalJarak = widget.listRiwayatPerjalanan['riwayatPerjalanan-${widget.idx}']
        ['totalJarak'];

    for (String line in listTemporary) {
      line = line.substring(1, line.length - 1);
      List<String> stringSementara = line.split(', ');

      List<double> doubleSementara = [];
      doubleSementara.add(double.parse(stringSementara[0]));
      doubleSementara.add(double.parse(stringSementara[1]));
      listLatLng.add(doubleSementara);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageTitle(
              sizedBoxTop: 90,
              title1: "Riwayat Perjalanan",
              title2: "Rekam jejak rute yang telah anda lewati.",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RoundedContainer(
                  verticalPadding: 10,
                  verticalMargin: 5,
                  borderRadius: 10,
                  width: 0.31,
                  child: Text(
                    'Tanggal',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                RoundedContainer(
                  verticalPadding: 10,
                  verticalMargin: 5,
                  borderRadius: 10,
                  width: 0.45,
                  child: Text(
                    tanggal,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RoundedContainer(
                  verticalPadding: 10,
                  verticalMargin: 5,
                  borderRadius: 10,
                  width: 0.31,
                  child: Text(
                    'Total Jarak',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                RoundedContainer(
                  verticalPadding: 10,
                  verticalMargin: 5,
                  borderRadius: 10,
                  width: 0.45,
                  child: Text(
                    '$totalJarak Km',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RoundedContainer(
                  verticalPadding: 10,
                  verticalMargin: 5,
                  borderRadius: 10,
                  width: 0.31,
                  child: Text(
                    'Total BBM',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                RoundedContainer(
                  verticalPadding: 10,
                  verticalMargin: 5,
                  borderRadius: 10,
                  width: 0.45,
                  child: Text(
                    '$totalBBM L',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            FinalstateButton(
              onpress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapHistoryTravel(
                      listLatLng: listLatLng,
                    ),
                  ),
                );
              },
              text: 'Lihat Peta',
            ),
            const SizedBox(
              height: 15,
            ),
            DataTable(
              columns: const [
                DataColumn(label: Text('No')),
                DataColumn(label: Text('Latitude')),
                DataColumn(label: Text('Longitude')),
              ],
              rows: List.generate(
                listLatLng.length,
                (index) => DataRow(
                  cells: [
                    DataCell(Text('${index + 1}')),
                    DataCell(Text('${listLatLng[index][0]}')),
                    DataCell(Text('${listLatLng[index][1]}')),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}
