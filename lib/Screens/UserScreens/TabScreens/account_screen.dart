import 'package:flutter/material.dart';
import 'package:travel/FireBase/firebase_functions.dart';
import 'package:travel/Styles/colors.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? temp;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: orange50,
                  radius: screenWidth * 0.24,
                  child: Text(
                    userName[0],
                    style: const TextStyle(
                      fontSize: 100,
                      color: orange,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.08),
                Column(
                  children: [
                    Text(
                      userName,
                      style: TextStyle(fontSize: screenWidth * 0.09),
                      overflow: TextOverflow.ellipsis,
                    ),
                    // SizedBox(
                    //   width: screenWidth * 0.3,
                    //   child: TextButton(
                    //     style: TextButton.styleFrom(
                    //       backgroundColor: Colors.orange.shade50,
                    //       foregroundColor: Colors.orange,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //     ),
                    //     onPressed: () {},
                    //     child: const Text("Edit Profile"),
                    //   ),
                    // )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          ListTile(
            leading: const Icon(Icons.email),
            title: Text(userEmail),
            
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          ListTile(
            leading: const Icon(Icons.phone_android),
            title: Text(userPhone),
            
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About"),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          )
        ],
      ),
    );
  }
}
