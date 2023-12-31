// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/colors.dart';

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
      backgroundColor: login_backgroundcolor,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.only(top: 150),
          padding: const EdgeInsets.symmetric(horizontal: 25),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(150)),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(children: [
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                const Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2),
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
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    loginbutton(context);
                  },
                  child: SizedBox(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.05,
                    child: Center(
                        child: loading
                            ? const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )
                            : const CircularProgressIndicator(
                                color: Colors.white,
                              )),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    "Don't have an Account?",
                    style: TextStyle(color: Colors.grey),
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
        final sharedpref = await SharedPreferences.getInstance();
        await sharedpref.setBool("KEY", true);
        Navigator.pushNamed(ctx, "HomePage");
      } on FirebaseAuthException catch (e) {
        setState(() {
          loading = true;
        });
        if (e.code == "invalid-credential") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Email and password incorrect"),
            backgroundColor: Colors.red,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Somethig Worng"),
            backgroundColor: Colors.red,
          ));
        }
      }
    }
  }
}
