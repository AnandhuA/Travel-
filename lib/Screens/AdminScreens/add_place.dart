import 'package:flutter/material.dart';
import 'package:travel/Functions/functions.dart';
import 'package:travel/Widgets/bottom_sheet.dart';
import 'package:travel/Widgets/button.dart';
import 'package:travel/Widgets/categories_dropdown.dart';
import 'package:travel/Widgets/dotted_container.dart';
import 'package:travel/Widgets/text_field_widet.dart';

class AddPlace extends StatelessWidget {
  const AddPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Place"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Textfield(label: "Add place"),
              const SizedBox(
                height: 10,
              ),
              Textfield(label: "District"),
              const SizedBox(
                height: 20,
              ),
              DottedContainer(
                  text: "Add Image",
                  height: 200,
                  width: double.infinity,
                  icon: Icons.camera_alt_outlined),
              Textfield(label: "Description", line: 4),
              const SizedBox(
                height: 20,
              ),
              const CategoriesDropdown(),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hotplaces.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100, // Set a fixed width or adjust as needed
                      child: Center(
                        child: Text("n"),
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  bottomSheet(context);
                },
                child: DottedContainer(
                    text: "Add Hot Places",
                    height: 100,
                    width: 100,
                    icon: Icons.add),
              ),
              const SizedBox(
                height: 20,
              ),
              addButton(onpress: () {})
            ],
          ),
        ),
      ),
    );
  }
}
