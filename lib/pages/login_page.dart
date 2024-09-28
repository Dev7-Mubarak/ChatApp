import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_filed.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
            CustomButton(
              title: 'Login',
              onTap: () {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'don\'t have an account?',
                  style: TextStyle(color: Colors.white),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, RegisterPage.id),
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
}
