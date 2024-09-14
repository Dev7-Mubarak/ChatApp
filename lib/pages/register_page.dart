import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_filed.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static const String id = 'RegisterPage';
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Form(
                child: Column(
                  children: [
                    CustomTextFiled(
                      hintText: 'Email',
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    CustomTextFiled(
                      hintText: 'Password',
                    )
                  ],
                ),
              ),
            ),
            const CustomButton(
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
