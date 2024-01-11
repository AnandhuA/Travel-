import 'package:flutter/material.dart';

Widget addButton({required onpress, String add = "Add", required Color color}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onpress,
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(
        add,
        style: const TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
      ),
    ),
  );
}
