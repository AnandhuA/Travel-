import 'package:flutter/material.dart';

class CategoriesDropdown extends StatefulWidget {
  const CategoriesDropdown({super.key});

  @override
  State<CategoriesDropdown> createState() => _CategoriesDropdownState();
}

class _CategoriesDropdownState extends State<CategoriesDropdown> {
  String selectedValue = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Select categories',
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
      value: selectedValue,
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue!;
        });
      },
      items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
