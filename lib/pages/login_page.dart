import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_filed.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password;
  final GlobalKey<FormState> _keyform = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: [
            const SizedBox(height: 75),
            const Image(
              image: AssetImage('assets/images/scholar.png'),
              height: 100,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Scholar Chat',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'pacifico'),
                ),
              ],
            ),
            const SizedBox(height: 75),
            const Row(children: [
              Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Form(
                key: _keyform,
                child: Column(
                  children: [
                    CustomFormTextFiled(
                      onChange: (value) => email = value,
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    CustomFormTextFiled(
                      onChange: (value) => password = value,
                      hintText: 'Password',
                    )
                  ],
                ),
              ),
            ),
            CustomButton(
              isLoading: isLoading,
              title: 'Login',
              onTap: () async {
                if (_keyform.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    await loginUser();
                    Navigator.pushNamed(context, chatPageId, arguments: email);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      showSnakBar(context, 'No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      showSnakBar(
                          context, 'Wrong password provided for that user.');
                    }
                    showSnakBar(context, e.toString());
                  }
                  setState(() {
                    isLoading = false;
                  });
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'don\'t have an account?',
                  style: TextStyle(color: Colors.white),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, RegisterPage.id,
                      arguments: email),
                  child: const Text(
                    '  Register',
                    style: TextStyle(color: Color(0xffC7EDE6)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
