import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_filed.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  static const String id = 'RegisterPage';
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            const Image(
              image: AssetImage('assets/images/scholar.png'),
            ),
            const Text(
              'Scholar Chat',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'pacifico'),
            ),
            const Spacer(
              flex: 2,
            ),
            const Row(children: [
              Text(
                'Register',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Form(
                child: Column(
                  children: [
                    CustomTextFiled(
                      onChange: (value) {
                        email = value;
                      },
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    CustomTextFiled(
                      onChange: (value) {
                        password = value;
                      },
                      hintText: 'Password',
                    )
                  ],
                ),
              ),
            ),
            CustomButton(
              onTap: () async {
                try {
                  UserCredential user = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email!, password: password!);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Weak Password')));
                  } else if (e.code == 'email-alredy-in-use') {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Email alredy in use')));
                  }
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Success')));
                }
              },
              title: 'Register',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'don\'t have an account?',
                  style: TextStyle(color: Colors.white),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context, 'LoginPage'),
                  child: const Text(
                    '  Login',
                    style: TextStyle(color: Color(0xffC7EDE6)),
                  ),
                ),
              ],
            ),
            const Spacer(
              flex: 3,
            )
          ],
        ),
      ),
    );
  }
}
