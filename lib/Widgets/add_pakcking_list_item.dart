// import 'package:flutter/material.dart';
// import 'package:travel/Functions/user_functions.dart';
// import 'package:travel/Models/user_model.dart';

// class AddPackingItem extends StatefulWidget {
//   const AddPackingItem({super.key});

//   @override
//   State<AddPackingItem> createState() => _AddPackingItemState();
// }

// class _AddPackingItemState extends State<AddPackingItem> {
//   String dropdownValue = '1 Item'; // Move this line here

//   @override
//  FutureWidget build(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text("Add Item"),
//             content: SizedBox(
//               height: size.height * 0.2,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextField(
//                     decoration: const InputDecoration(
//                       label: Text("Item"),
//                     ),
//                     controller: itemController,
//                   ),
//                   DropdownButton<String>(
//                     value: dropdownValue,
//                     icon: const Icon(Icons.keyboard_arrow_down_outlined),
//                     onChanged: (newValue) {
//                       setState(() {
//                         dropdownValue = newValue ?? "";
//                       });
//                     },
//                     items:
//                         dropList.map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   if (itemController.text.isNotEmpty) {
//                     addPackingItems(
//                       packingModel: PackingListModel(
//                         id: DateTime.now().microsecondsSinceEpoch.toString(),
//                         item: itemController.text,
//                         tripId: widget.id,
//                         check: false,
//                       ),
//                     );
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: const Text("Add"),
//               ),
//             ],
//           );
//         });
//   }
// }
