import 'package:flutter/material.dart';
import 'package:travel/colors.dart';

Widget addButton({required onpress, String add = "Add"}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onpress,
      style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
      child: Text(
        add,
        style: const TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
      ),
    ),
  );
}
