import 'package:flutter/material.dart';
import 'package:rajoongan/app/components/button/finalstate_button.dart';
import 'package:rajoongan/app/components/form/form_hasil_tangkap.dart';
import 'package:rajoongan/app/components/text-field/rounded_input_field_without_icon.dart';
import 'package:rajoongan/app/components/title/page_title.dart';
import 'package:rajoongan/app/constants/color.dart';

import 'base_view.dart';

class FormPageHasilTangkap extends StatefulWidget {
  int idx;
  FormPageHasilTangkap({Key? key, required this.idx}) : super(key: key);

  @override
  State<FormPageHasilTangkap> createState() => _FormPageHasilTangkapState();
}

class _FormPageHasilTangkapState extends State<FormPageHasilTangkap> {
  int cnt = 1;
  final TextEditingController _date = TextEditingController();
  List<TextEditingController> listNamaTangkapan = <TextEditingController>[
    TextEditingController()
  ];
  List<TextEditingController> listTotalBerat = <TextEditingController>[
    TextEditingController()
  ];
  List<TextEditingController> listHargaPasaran = <TextEditingController>[
    TextEditingController()
  ];

  List<String> allNamaTangkapan = [];
  double totalBerat = 0, totalHarga = 0;
  void calculateAll() {
    totalHarga = 0;
    totalBerat = 0;
    allNamaTangkapan = [];
    for (int i = 0; i < listNamaTangkapan.length; i++) {
      totalHarga += double.parse(listTotalBerat[i].text) *
          double.parse(listHargaPasaran[i].text);
      totalBerat += double.parse(listTotalBerat[i].text);
      allNamaTangkapan.add(listNamaTangkapan[i].text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 40, top: 60),
      child: Column(
        children: [
          PageTitle(
            title1: "Hasil Tangkap",
            title2: "Hitung dan catat hasil tangkapan anda",
          ),
          RoundedInputFieldWithoutIcon(
            textEditingController: _date,
            inputType: TextInputType.text,
            labelText: 'Tanggal',
            hintText: "Hari, Tanggal Bulan Tahun",
            onChanged: (value) {},
            fontSize: 15,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            itemCount: cnt,
            itemBuilder: (BuildContext context, int index) {
              return FormHasilTangkap(
                namaTangkapanController: listNamaTangkapan[index],
                totalBeratController: listTotalBerat[index],
                hargaPasaranController: listHargaPasaran[index],
                indexForm: index + 1,
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FinalstateButton(
                onpress: () {
                  calculateAll();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BaseViewHasilTangkap(
                        allNamaTangkapan: allNamaTangkapan,
                        totalBerat: totalBerat,
                        totalHarga: totalHarga,
                        tanggal: _date.text,
                        idxPageKalkulasi: widget.idx,
                        show: 'PageKalkulasi',
                      ),
                    ),
                  );
                },
                text: 'Selesai',
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(15),
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
                    cnt++;
                    listNamaTangkapan.add(TextEditingController());
                    listHargaPasaran.add(TextEditingController());
                    listTotalBerat.add(TextEditingController());
                    setState(() {});
                  },
                  color: Colors.white,
                  iconSize: 20,
                  tooltip: 'Add',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
