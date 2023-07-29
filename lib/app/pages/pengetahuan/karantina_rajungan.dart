import 'package:flutter/material.dart';
import 'package:rajoongan/app/components/button/back_button_map.dart';
import 'package:rajoongan/app/components/title/page_title.dart';
import 'package:rajoongan/app/constants/color.dart';

class KarantinaRajunganPage extends StatelessWidget {
  const KarantinaRajunganPage({super.key});

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;

    List<String> stepCaraKarantina = [
      "Rajungan pembawa telur diletakkan pada ember berisi air saat di laut.",
      "Setelah sampai dipesisir, rajungan pembawa telur dipindahkan kedalam wangsal/wadah sejenisnya. Maksimal diisi 2 ekor.",
      "Setelah itu wangsal berisi rajungan pembawa telur ditenggelamkan hingga dasar perairan dan diikat.",
      "Tunggu waktu inkubasi telur selesai agar rajungan melepaskan semua telurnya. lalu indukan dapat diambil.",
    ];

    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Container(
              // color: Colors.red,
              margin: const EdgeInsets.only(
                left: 30,
                right: 30,
                bottom: 30,
                top: 60,
              ),
              child: Column(
                children: [
                  PageTitle(
                    title1: "Karantina Rajungan Bertelur",
                    title2: "",
                    sizedBoxBottom: 10,
                  ),
                  const Text(
                    '''Rajungan betina membawa ribuan telurnya pada bagian abdomen mereka. telur-telur tersebut berada disana hingga masa inkubasi selesai. Selama periode inkubasi, Rajungan betina akan selalu membawa telurnya dan melindunginya.
                    
            Pemerintah Indonesia telah melarang penangkapan rajungan dengan kondisi sedang membawa telur agar dapat menjaga kelestarian rajungan. Direktur Jenderal Perikanan Tangkap, Bapak M. Zulficar Mochtar mengatakan seberapa besar potensi yang dapat dihasilkan dari satu ekor rajungan pembawa telur.''',
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: primaryColor),
                  ),
                  SizedBox(
                    height: maxHeight * 0.01,
                  ),
                  SizedBox(
                    height: maxHeight * 0.2,
                    child: Image.asset(
                      "assets/images/karantina_rajungan/karantina1.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: maxHeight * 0.01,
                  ),
                  const Text(
                    '''Oleh karena itu, apabila nelayan rajungan mendapatkan hasil tangkapan berupa rajungan pembawa telur, maka perlu dilakukan karantina pelepasan telur terlebih dahulu. Berikut merupakan cara melakukannya:''',
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: primaryColor),
                  ),
                  SizedBox(
                    height: maxHeight * 0.01,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              index < 4
                                  ? Expanded(
                                      flex: 1,
                                      child: Text(
                                        "${index + 1}",
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                            color: primaryColor),
                                      ),
                                    )
                                  : const SizedBox(),
                              index < 4
                                  ? Expanded(
                                      flex: 9,
                                      child: Text(
                                        stepCaraKarantina[index],
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                            color: primaryColor),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          SizedBox(
                            height: maxHeight * 0.01,
                          ),
                          SizedBox(
                            width: maxWidth * 0.76,
                            child: Image.asset(
                              "assets/images/karantina_rajungan/karantina${index + 2}.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: maxHeight * 0.02,
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: maxHeight * 0.02,
                  ),
                  const Text(
                    '''Sumber: 
            darilaut.id dan Forum Komunikasi Nelayan Rajungan Nusantara''',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: primaryColor, fontSize: 16, shadows: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 3),
                        blurRadius: 8,
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
        const BackButtonOnMap(),
      ],
    );
  }
}
