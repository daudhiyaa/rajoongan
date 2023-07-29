import 'package:flutter/material.dart';
import 'package:rajoongan/app/components/button/back_button_map.dart';
import 'package:rajoongan/app/components/container/value_unit_container.dart';
import 'package:rajoongan/app/components/title/page_title.dart';
import 'package:rajoongan/app/constants/color.dart';
import 'package:rajoongan/app/models/money_converter.dart';
import 'package:rajoongan/app/pages/hasil_tangkap/base_view.dart';

class HasilTangkapPage extends StatefulWidget {
  Map listTangkapan;

  HasilTangkapPage({
    Key? key,
    this.listTangkapan = const {},
  }) : super(key: key);

  @override
  State<HasilTangkapPage> createState() => _HasilTangkapPageState();
}

class _HasilTangkapPageState extends State<HasilTangkapPage> {
  List<String> cardTitles = [];

  void setData(int len) {
    for (int i = 1; i <= len; i++) {
      cardTitles.add(widget.listTangkapan['tangkapan-$i']['tanggal']);
      cardTitles.add(
          'Berat : ${widget.listTangkapan['tangkapan-$i']['totalBerat']} kg');
      double tempTotalKeuntungan =
          widget.listTangkapan['tangkapan-$i']['totalKeuntungan'];
      String temp =
          convertNumberToMoney(tempTotalKeuntungan, tempTotalKeuntungan.abs());
      cardTitles.add('Keuntungan : $temp');
    }
  }

  @override
  void initState() {
    setData(widget.listTangkapan.length);
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
                          builder: (context) => BaseViewHasilTangkap(
                            show: 'FormPage',
                            idxPageKalkulasi: widget.listTangkapan.length,
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
                  title1: "Hasil Tangkap",
                  title2: "Hitung dan catat hasil tangkapan anda",
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  itemCount: widget.listTangkapan.length,
                  itemBuilder: (BuildContext context, int idx) {
                    return GestureDetector(
                      onTap: () {
                        // print(listTangkapan['tangkapan-${idx + 1}']);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BaseViewHasilTangkap(
                              allNamaTangkapan:
                                  widget.listTangkapan['tangkapan-${idx + 1}']
                                      ['tangkapan'],
                              totalBerat:
                                  widget.listTangkapan['tangkapan-${idx + 1}']
                                      ['totalBerat'],
                              totalHarga:
                                  widget.listTangkapan['tangkapan-${idx + 1}']
                                      ['totalHarga'],
                              tanggal:
                                  widget.listTangkapan['tangkapan-${idx + 1}']
                                      ['tanggal'],
                              idxPageKalkulasi: idx,
                              show: 'PageKalkulasi',
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
