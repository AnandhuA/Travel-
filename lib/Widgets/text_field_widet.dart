import 'package:flutter/material.dart';

Widget Textfield({required String label, TextEditingController? controller, int? line}) {
  return TextField(
    controller: controller,
    maxLines: line,
    decoration: InputDecoration(
        border: UnderlineInputBorder(), label: Text(label)),
  );
}
