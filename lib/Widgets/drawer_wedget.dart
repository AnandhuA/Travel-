import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/colors.dart';

Widget drawer(context) {
  return Drawer(
    child: ListView(
      padding: const EdgeInsets.only(top: 150),
      children: [
        const CircleAvatar(
          radius: 70,
          child: Icon(
            Icons.person,
            size: 70,
          ),
        ),
        Center(
          child: Text(loginuser.name),
        ),
        const SizedBox(
          height: 50,
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.logout,
            color: red,
          ),
          title: const Text(
            'Logout',
            style: TextStyle(color: red),
          ),
          onTap: () {
            logout(context);
          },
        ),
      ],
    ),
  );
}

logout(context) async {
  // final sharedpref = await SharedPreferences.getInstance();
  FirebaseAuth.instance.signOut();
  // await sharedpref.clear();
  Navigator.pushNamedAndRemoveUntil(context, "Login", (route) => false);
}
