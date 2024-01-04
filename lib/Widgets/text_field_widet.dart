import 'package:flutter/material.dart';

Widget textField(
    {required String label,
    TextEditingController? controller,
    int? line,
    String? text}) {
  if (controller != null && text != null) {
    controller.text = text;
  }
  return TextField(
    controller: controller,
    maxLines: line,
    decoration: InputDecoration(
        border: const UnderlineInputBorder(), label: Text(label)),
  );
}
