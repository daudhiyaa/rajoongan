import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:get/get.dart';
import 'package:rajoongan/app/components/button/rounded_button.dart';
import 'package:rajoongan/app/components/text-field/rounded_input_field.dart';
import 'package:rajoongan/app/constants/color.dart';
import 'package:rajoongan/app/routes/app_pages.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _usn = TextEditingController();
  final TextEditingController _namaKapal = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordVerification = TextEditingController();

  bool showPassword = true, showConfirmPassword = true;

  bool passwordConfirmed() {
    return (_password.text.trim() == _passwordVerification.text.trim())
        ? true
        : false;
  }

  Future addUserDetails(
    String email,
    String nama,
    String namaKapal,
    String uid,
  ) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      {
        'nama': nama,
        'email': email,
        'namaKapal': namaKapal,
        'jenisMesin': '',
        'kecepatanDinas': '10',
        'horsePower': '20',
        'kelompokNelayan': '',
        'totalTangkapan': 0,
        'listTangkapan': {},
        'listRiwayatPerjalanan': {},
      },
    );

    final imageBytes = await rootBundle.load('assets/images/profile.png');
    try {
      final ref =
          storage.FirebaseStorage.instance.ref().child('images').child(uid);
      final uploadTask = ref.putData(imageBytes.buffer.asUint8List());
      final snapshot = await uploadTask.whenComplete(() => null);

      final downloadURL = await snapshot.ref.getDownloadURL();
      print('ini downloadURL $downloadURL');
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text,
          password: _password.text,
        );

        String uid = userCredential.user!.uid;
        addUserDetails(_email.text, _usn.text, _namaKapal.text, uid);
        Get.offAllNamed(Routes.LOGIN);
      } on FirebaseAuthException catch (e) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              // color: Colors.red,
              height: 190,
              child: Image.asset(
                "assets/icons/rajoongan-icon.png",
                fit: BoxFit.contain,
              ),
            ),
            const Center(
              child: Text(
                "Silahkan Daftar",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Center(
              child: Text(
                "Buatlah akun baru untuk anda.",
                style: TextStyle(
                  color: lightBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: RoundedInputField(
                textEditingController: _usn,
                labelText: "Nama",
                onChanged: (value) {},
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: RoundedInputField(
                textEditingController: _namaKapal,
                labelText: "Nama Kapal",
                icon: Icons.directions_boat,
                onChanged: (value) {},
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: RoundedInputField(
                textEditingController: _email,
                labelText: "Email",
                icon: Icons.email,
                onChanged: (value) {},
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: RoundedInputField(
                textEditingController: _password,
                labelText: "Password",
                icon: Icons.lock,
                onChanged: (value) {},
                suffixIcon: IconButton(
                  icon: const Icon(Icons.visibility),
                  color: primaryColor,
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
                obsecureText: showPassword,
                enableSuggestion: false,
                autoCorrect: false,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: RoundedInputField(
                textEditingController: _passwordVerification,
                labelText: "Konfirmasi Password",
                icon: Icons.lock,
                onChanged: (value) {},
                suffixIcon: IconButton(
                  icon: const Icon(Icons.visibility),
                  color: primaryColor,
                  onPressed: () {
                    setState(() {
                      showConfirmPassword = !showConfirmPassword;
                    });
                  },
                ),
                obsecureText: showConfirmPassword,
                enableSuggestion: false,
                autoCorrect: false,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: RoundedBotton(
                text: "Daftar",
                press: () => {
                  signUp(),
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sudah memiliki akun?",
                  style: TextStyle(
                    color: lightBlue,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.LOGIN),
                  child: const Text(
                    "Masuk.",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
