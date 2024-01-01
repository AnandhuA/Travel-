import 'package:flutter/material.dart';

Widget textField({required String label, TextEditingController? controller, int? line}) {
  return TextField(
    controller: controller,
    maxLines: line,
    decoration: InputDecoration(
        border: const UnderlineInputBorder(), label: Text(label)),
  );
}
