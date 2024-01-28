import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future<List<String>> uploadImage({required List<XFile> images}) async {
  Reference referenceRoot = FirebaseStorage.instance.ref();
  Reference referenceDirImages = referenceRoot.child("Images");
  List<String> urls = [];
  for (int i = 0; i < images.length; i++) {
    Reference referenceImageToUpload = referenceDirImages.child(images[i].name);
    try {
      await referenceImageToUpload.putFile(File(images[i].path));
      urls.add(await referenceImageToUpload.getDownloadURL());

      print(urls);
    } catch (e) {
      print("============$e");
    }
  }
  return urls;
}