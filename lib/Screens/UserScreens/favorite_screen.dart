import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color.fromARGB(138, 255, 155, 147)),
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
              child: ListTile(
                leading: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                title: const Text("Favorite"),
                subtitle: const Text("data"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: CircleAvatar(
                    radius: 13,
                    backgroundColor: Colors.red.shade100,
                    child: const Icon(
                      Icons.favorite,
                      size: 17,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 30,
            );
          },
          itemCount: 10),
    );
  }
}
