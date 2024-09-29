import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_filed.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  final GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  // AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
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
                key: formKey,
                child: Column(
                  children: [
                    CustomFormTextFiled(
                      onChange: (value) {
                        email = value;
                      },
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    CustomFormTextFiled(
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
              isLoading: isLoading,
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    await registerUser();
                    showSnakBar(context, 'Success');
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      showSnakBar(context, 'Weak Password');
                    } else if (e.code == 'email-alredy-in-use') {
                      showSnakBar(context, 'Email alredy in use');
                    }
                    showSnakBar(context, e.toString());
                  } catch (e) {
                    showSnakBar(context, e.toString());
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                } else {}
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

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
