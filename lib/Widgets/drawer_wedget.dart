import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        const Center(
            child: Text(
          "Admin",
          style: TextStyle(fontSize: 40),
        )),
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
            color: Colors.red,
          ),
          title: const Text(
            'Logout',
            style: TextStyle(color: Colors.red),
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
  final sharedpref = await SharedPreferences.getInstance();
  FirebaseAuth.instance.signOut();
  await sharedpref.clear();
  Navigator.pushNamedAndRemoveUntil(context, "Login", (route) => false);
}
