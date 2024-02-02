// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/Styles/animation.dart';
import 'package:travel/Styles/colors.dart';
import 'package:travel/Styles/text_style.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  bool loading = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: loginBackgroundColor,
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            left: 0,
            top: 30,
            child: Image.asset(
              "Assets/Images/6.png",
              width: 200,
            ),
          ),
          Positioned(
            right: 0,
            top: 18,
            child: Image.asset(
              "Assets/Images/1.png",
              width: 240,
            ),
          ),
          Container(
            height: double.infinity,
            margin: const EdgeInsets.only(top: 100),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(142),
              ),
              color: white,
              gradient: backgroundGradientLogin,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Text(
                      "Sign Up",
                      style: signupstyle1,
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter name";
                        } else {
                          return null;
                        }
                      },
                      controller: usernameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        label: Text("Name"),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Email";
                        } else {
                          return null;
                        }
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        label: Text("Email"),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter phone number";
                        } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                          return "Invalid phone number";
                        } else {
                          return null;
                        }
                      },
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        label: Text("Phone"),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Password";
                        } else {
                          return null;
                        }
                      },
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        label: Text("Password"),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor),
                      onPressed: () {
                        signUp();
                      },
                      child: SizedBox(
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.05,
                        child: Center(
                          child: loading
                              ? Text("Sign up", style: textstyle1)
                              : const CircularProgressIndicator(
                                  color: white,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an Account ",
                          style: TextStyle(color: grey),
                        ),
                        InkWell(
                          onTap: () => Navigator.pushNamed(context, "Login"),
                          child: const Text(
                            "Login",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  signUp() async {
    final CollectionReference user =
        FirebaseFirestore.instance.collection("Users");
    if (formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      setState(() {
        loading = false;
      });
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (_auth.currentUser!.email != null) {
          user.doc(_auth.currentUser!.email).set(
            {"Name": usernameController.text, "Phone": phoneController.text},
          );
          // getUser();

          animationSignup(context: context);
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          loading = true;
        });

        if (e.code == "weak-password") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Password should be at least 6 character"),
            backgroundColor: red,
          ));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Email already in use"),
            backgroundColor: red,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("something wrong"),
            backgroundColor: red,
          ));
        }
      }
    }
  }
}
