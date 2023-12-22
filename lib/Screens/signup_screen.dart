import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              "Sign Up",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 70,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(150)),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    TextFormField(
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
                          backgroundColor: Colors.black),
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
                          "Already have an Account",
                          style: TextStyle(color: Colors.grey),
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
}
