import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rajoongan/app/components/button/rounded_button.dart';
import 'package:rajoongan/app/components/text-field/rounded_input_field.dart';
import 'package:rajoongan/app/constants/color.dart';
import 'package:rajoongan/app/routes/app_pages.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool showPassword = true;

  Future login() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      // print(userCredential);

      Get.offAllNamed(Routes.HOME);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 360,
              width: 360,
              child: Image.asset(
                "assets/images/tangkap.png",
                fit: BoxFit.cover,
              ),
            ),
            const Center(
              child: Text(
                "Selamat Datang",
                style: TextStyle(
                  color: Color(0xFF116BF5),
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
                "Silahkan masuk dengan akun anda.",
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
                textEditingController: _email,
                labelText: "Email",
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
            TextButton(
              onPressed: () {},
              style: const ButtonStyle(alignment: Alignment.center),
              child: const Text(
                "Lupa Kata Sandi?",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: RoundedBotton(
                text: "Masuk",
                press: () {
                  login();
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Belum memiliki akun?",
                  style: TextStyle(
                    color: lightBlue,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.SIGNUP),
                  child: const Text(
                    "Daftar.",
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
