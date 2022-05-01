import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user_model.dart';
import 'package:flutter_firebase/views/loggin_page.dart';
import 'package:flutter_firebase/widgets/custom_textfield.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final address = TextEditingController();

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
        title: const Text('Register Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CustomTextfeild(
                  hintText: ' First Name',
                  prefixIcon: Icons.person,
                  controller: firstName,
                ),
                mainHeight,
                CustomTextfeild(
                  hintText: 'Last Name',
                  prefixIcon: Icons.person,
                  controller: lastName,
                ),
                mainHeight,
                CustomTextfeild(
                  hintText: 'Address',
                  prefixIcon: Icons.location_on,
                  controller: address,
                ),
                mainHeight,
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
                    create(
                      email.text.trim(),
                      password.text.trim(),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Create'),
                ),
                mainHeight,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Already an account'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text('Login'),
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

  Future create(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      postToFireStore(firstName.text, lastName.text, address.text);
    });
  }

  Future postToFireStore(
      String firstName, String lastName, String address) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? users = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel(
      uid: users?.uid,
      firstName: firstName,
      lastName: lastName,
      email: users?.email,
      address: address,
    );

    // writing all the values
    // userModel.email = user!.email;
    // userModel.uid = user.uid;
    // userModel.firstName = firstNameController.text;
    // userModel.secondName = secondNameController.text;

    await firebaseFirestore
        .collection("users")
        .doc(users?.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(
      msg: "Account created successfully :) ",
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
}
