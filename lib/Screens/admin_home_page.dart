import 'package:flutter/material.dart';
import 'package:travel/Widgets/drawer_wedget.dart';
import 'package:travel/Widgets/home_page_wedgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: drawer(context),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search"),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontSize: 30),
                ),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text("Add categories"))
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return categories();
                  }),
            ),

            // Container(
            //   height: 200,
            //   child: GridView.builder(
            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2,
            //       ),
            //       itemCount: 5,
            //       itemBuilder: ((context, index) {
            //         return categories();
            //       })),
            // )

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Places",
                  style: TextStyle(fontSize: 30),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text("Add new place"),
                )
              ],
            ),
          
          ],
        ),
      ),
    );
  }
}
