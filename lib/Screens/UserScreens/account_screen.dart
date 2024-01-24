import 'package:flutter/material.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Widgets/text_field_widet.dart';
import 'package:travel/colors.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: orange50,
                  radius: 100,
                  child: Text(
                    loginuser.name[0],
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
                      loginuser.name,
                      style: const TextStyle(fontSize: 30),
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
            title: Text(loginuser.email),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Edit Email"),
                      content: textField(
                          label: "Edit Email",
                          keyboard: TextInputType.emailAddress,
                          controller: emailController,
                          text: loginuser.email),
                      actions: [
                        ElevatedButton(
                          onPressed: () async {
                            if (emailController.text.isNotEmpty) {
                              UserDetailsModel user = UserDetailsModel(
                                id: loginuser.id,
                                name: loginuser.name,
                                email: emailController.text,
                                phone: loginuser.phone,
                              );
                              await editUser(user);
                              setState(() {
                                temp = emailController.text;
                              });
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Enter Email"),
                                backgroundColor: red,
                              ));
                            }
                          },
                          child: const Text("Add"),
                        )
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          ListTile(
            leading: const Icon(Icons.phone_android),
            title: Text(loginuser.phone),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Edit Phone Number"),
                      content: textField(
                          label: "Edit ",
                          keyboard: TextInputType.phone,
                          controller: phoneController,
                          text: loginuser.phone),
                      actions: [
                        ElevatedButton(
                          onPressed: () async {
                            if (phoneController.text.isNotEmpty) {
                              UserDetailsModel user = UserDetailsModel(
                                id: loginuser.id,
                                name: loginuser.name,
                                email: loginuser.email,
                                phone: phoneController.text,
                              );
                              await editUser(user);
                              setState(() {
                                temp = phoneController.text;
                              });
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Enter Phone Number"),
                                backgroundColor: red,
                              ));
                            }
                          },
                          child: const Text("Add"),
                        )
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.edit),
            ),
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
