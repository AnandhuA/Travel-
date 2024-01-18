import 'package:flutter/material.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Widgets/text_field_widet.dart';

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
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 100,
                  child: Text(
                    loginuser.name[0],
                    style: const TextStyle(fontSize: 100),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Text(
                      loginuser.name,
                      style: const TextStyle(fontSize: 40),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Edit Profile"),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
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
                                backgroundColor: Colors.red,
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
          const SizedBox(
            height: 20,
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
                                backgroundColor: Colors.red,
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
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About"),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ),
          const SizedBox(
            height: 20,
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
