import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {},
                child: SizedBox(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.05,
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
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
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
