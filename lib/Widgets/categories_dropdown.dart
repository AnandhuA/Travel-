import 'package:flutter/material.dart';
import 'package:travel/FireBase/firebase_functions.dart';
import 'package:travel/Models/admin_model.dart';
import 'package:travel/Styles/colors.dart';

String? value;
CategoriesModel? categorie;

class CategoriesDropdown extends StatefulWidget {
  const CategoriesDropdown({super.key});

  @override
  State<CategoriesDropdown> createState() => _CategoriesDropdownState();
}

class _CategoriesDropdownState extends State<CategoriesDropdown> {
  @override
  Widget build(BuildContext context) {
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
        color: black,
        fontSize: 18,
      ),
      value: value,
      onChanged: (String? newValue) {
        setState(() {
          value = newValue;
        });
      },
      items: categorieList
          .map<DropdownMenuItem<String>>((CategoriesModel value) {
        return DropdownMenuItem<String>(
          value: value.categorie,
          child: Text(value.categorie),
          onTap: () {
            categorie = value;
          },
        );
      }).toList(),
    );
  }
}

CategoriesModel? dropdownCategorie() {
  return categorie;
}

String? dropdownValue() {
  return value;
}
