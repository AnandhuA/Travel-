// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/FireBase/firebase_functions.dart';
import 'package:travel/Styles/colors.dart';

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
          child: Text(userName),
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

logout(context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to Logout?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, "Login", (route) => false);
            },
            child: const Text("Yes"),
          )
        ],
      );
    },
  );
}
