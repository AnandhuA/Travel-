import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Styles/colors.dart';

class PackingListScreen extends StatelessWidget {
  final int id;
  PackingListScreen({super.key, required this.id});

  final TextEditingController itemController = TextEditingController();

  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add Item"),
                content: SizedBox(
                  height: size.height * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          label: Text("Item"),
                        ),
                        controller: itemController,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text("Quantity"),
                        ),
                        controller: quantityController,
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (itemController.text.isNotEmpty) {
                        addPackingItems(
                          packingModel: PackingListModel(
                            id: DateTime.now()
                                .microsecondsSinceEpoch
                                .toString(),
                            item: itemController.text,
                            quantity: quantityController.text,
                            tripId: id,
                            check: false,
                          ),
                        );
                        itemController.clear();
                        quantityController.clear();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Add"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Packing List"),
      ),
      body: ValueListenableBuilder(
        valueListenable: items,
        builder: (context, value, child) {
          List<PackingListModel> newlist = [];
          for (int i = 0; i < items.value.length; i++) {
            if (items.value[i].tripId == id) {
              newlist.add(items.value[i]);
            }
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              return Slidable(
                key: Key(newlist[index].id.toString()),
                startActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: StretchMotion(),
                  ),
                  children: [
                    SlidableAction(
                      borderRadius: BorderRadius.circular(15),
                      backgroundColor: red50,
                      autoClose: true,
                      onPressed: (context) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text("Delete successfully"),
                          backgroundColor: black,
                        ));
                        delectPackingIteam(
                          packingModel: newlist[index],
                        );
                      },
                      foregroundColor: red,
                      icon: Icons.delete,
                      label: "Delect",
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: StretchMotion(),
                  ),
                  children: [
                    SlidableAction(
                      borderRadius: BorderRadius.circular(15),
                      backgroundColor: red50,
                      autoClose: true,
                      onPressed: (context) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text("Delete successfully"),
                          backgroundColor: black,
                        ));
                        delectPackingIteam(
                          packingModel: newlist[index],
                        );
                      },
                      foregroundColor: red,
                      icon: Icons.delete,
                      label: "Delect",
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    title: Text(
                      "${newlist[index].item} (${newlist[index].quantity} )",
                      style: const TextStyle(
                        color: black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Checkbox(
                      activeColor: green,
                      onChanged: (value) {
                        if (value != null) {
                          addPackingItems(
                            packingModel: PackingListModel(
                              id: newlist[index].id,
                              item: newlist[index].item,
                              tripId: newlist[index].tripId,
                              quantity: newlist[index].quantity,
                              check: value,
                            ),
                          );
                        }
                      },
                      value: newlist[index].check,
                    ),
                    tileColor: blue50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 5,
            ),
            itemCount: newlist.length,
          );
        },
      ),
    );
  }
}
