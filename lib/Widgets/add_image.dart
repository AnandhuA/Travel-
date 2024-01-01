import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/Widgets/dotted_container.dart';

class AddImage extends StatelessWidget {
   AddImage({super.key});
  
  late XFile file;
  String image = "";

  @override
  Widget build(BuildContext context) {
    return  InkWell(
                onTap: () async {
                  file = (await ImagePicker()
                      .pickImage(source: ImageSource.gallery))!;
                      
                },
                child: image.isEmpty
                    ? dottedContainer(
                        text: "Add Image",
                        height: 200,
                        width: double.infinity,
                        icon: Icons.camera_alt_outlined)
                    : SizedBox(
                        height: 200,
                        width: double.infinity,
                        child:  Image.file(File(image)),
                      ),
              );
  }
}