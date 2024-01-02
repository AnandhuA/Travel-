import 'package:flutter/material.dart';
import 'package:travel/Functions/functions.dart';
import 'package:travel/Models/model.dart';

String? value;

class CategoriesDropdown extends StatefulWidget {
  const CategoriesDropdown({super.key});

  @override
  State<CategoriesDropdown> createState() => _CategoriesDropdownState();
}

class _CategoriesDropdownState extends State<CategoriesDropdown> {
  @override
  Widget build(BuildContext context) {
    print(categorieList.value.map((value) => value.categorie).toList());

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: 'Select categories',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      value: value,
      onChanged: (String? newValue) {
        setState(() {
          value = newValue;
        });
      },
      items: categorieList.value
          .map<DropdownMenuItem<String>>((CategoriesModel value) {
            return DropdownMenuItem<String>(
              value: value.categorie,
              child: Text(value.categorie),
            );
          })
         
          .toList(),
    );
  }
}

String? dropdownValue() {
  return value;
}
