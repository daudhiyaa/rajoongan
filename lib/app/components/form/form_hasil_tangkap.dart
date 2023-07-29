import 'package:flutter/material.dart';
import 'package:rajoongan/app/components/text-field/rounded_input_field_without_icon.dart';

class FormHasilTangkap extends StatelessWidget {
  int indexForm;
  final TextEditingController namaTangkapanController;
  final TextEditingController totalBeratController;
  final TextEditingController hargaPasaranController;
  FormHasilTangkap({
    super.key,
    required this.indexForm,
    required this.namaTangkapanController,
    required this.totalBeratController,
    required this.hargaPasaranController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        // color: Colors.red,
        child: Column(
          children: [
            RoundedInputFieldWithoutIcon(
              inputType: TextInputType.text,
              textEditingController: namaTangkapanController,
              labelText: "Nama Tangkapan $indexForm",
              hintText: '',
              onChanged: (value) {},
              fontSize: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RoundedInputFieldWithoutIcon(
                  inputType: TextInputType.number,
                  textEditingController: totalBeratController,
                  width: 0.66,
                  fontSize: 15,
                  labelText: "Total Berat",
                  hintText: '',
                  onChanged: (value) {},
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  width: 45,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF116BF5),
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
                  child: const Text(
                    'Kg',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RoundedInputFieldWithoutIcon(
                  inputType: TextInputType.number,
                  textEditingController: hargaPasaranController,
                  width: 0.66,
                  fontSize: 15,
                  labelText: "Harga Pasaran",
                  hintText: '',
                  onChanged: (value) {},
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  width: 45,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF116BF5),
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
                  child: const Text(
                    'Rp',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
