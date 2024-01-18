import 'package:flutter/material.dart';

Widget textField(
    {required String label,
    TextEditingController? controller,
    InputBorder boder = const UnderlineInputBorder(),
    int? line,
    String? text,
    Widget? icon,
    TextInputType? keyboard}) {
  if (controller != null && text != null) {
    controller.text = text;
  }
  return TextField(
    keyboardType: keyboard,
    controller: controller,
    maxLines: line,
    decoration:
        InputDecoration(border: boder, label: Text(label), suffixIcon: icon),
  );
}
