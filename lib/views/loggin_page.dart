import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/views/register_page.dart';
import 'package:flutter_firebase/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const mainHeight = SizedBox(height: 20.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CustomTextfeild(
                  hintText: 'Email',
                  prefixIcon: Icons.email,
                  controller: email,
                ),
                mainHeight,
                CustomTextfeild(
                  obscureText: true,
                  hintText: 'Password',
                  prefixIcon: Icons.lock,
                  controller: password,
                ),
                mainHeight,
                ElevatedButton.icon(
                  onPressed: () {
                    login(
                      email.text.trim(),
                      password.text.trim(),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                  label: const Text('Log In'),
                ),
                mainHeight,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Don\'t have an account'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}
