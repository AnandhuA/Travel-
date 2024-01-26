// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Styles/colors.dart';
import 'package:travel/main.dart';
import 'package:travel/Styles/text_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: loginBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 130,
            child: Image.asset(
              "Assets/Images/6.png",
              width: 200,
            ),
          ),
          Positioned(
            right: 0,
            top: 119,
            child: Image.asset(
              "Assets/Images/1.png",
              width: 240,
            ),
          ),
          Container(
            height: double.infinity,
            margin: const EdgeInsets.only(top: 200),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(142)),
                color: white,
                gradient: backgroundGradientLogin),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                   Text(
                    "Login",
                    style: loginstyle1,
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Email";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      label: Text("Email"),
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Password";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      label: Text("Password"),
                      border: UnderlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: buttonColor),
                    onPressed: () {
                      loginbutton(context);
                    },
                    child: SizedBox(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.05,
                      child: Center(
                          child: loading
                              ?  Text(
                                  "Login",
                                  style: textstyle1,
                                )
                              : const CircularProgressIndicator(
                                  color: white,
                                )),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      "Don't have an Account?",
                      style: TextStyle(color: grey),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, "Signup"),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ])
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  loginbutton(ctx) async {
    if (formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      setState(() {
        loading = false;
      });

      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        // final sharedpref = await SharedPreferences.getInstance();
        // await sharedpref.setBool("KEY", true);
        getUser();
        userRefresh();
        if (_auth.currentUser != null) {
          if (_auth.currentUser!.email == "anandhu1407@gmail.com") {
            admin = true;
            Navigator.pushNamedAndRemoveUntil(
                context, "AdminHomePage", (route) => false);
          } else {
            admin = false;
            Navigator.pushNamedAndRemoveUntil(
                context, "IntroPage", (route) => false);
          }
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          loading = true;
        });
        if (e.code == "invalid-credential") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Email and password incorrect"),
            backgroundColor: red,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Somethig Worng"),
            backgroundColor: red,
          ));
        }
      }
    }
  }
}
