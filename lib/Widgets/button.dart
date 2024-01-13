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

Widget textButton(
    {required String title,
    required Function fun,
    required Color color}) {
  return InkWell(
    onTap: () => fun(),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(title,style: TextStyle(color: color),),
    ),
  );
}
