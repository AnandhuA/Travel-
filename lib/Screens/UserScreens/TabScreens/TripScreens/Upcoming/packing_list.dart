import 'package:flutter/material.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Widgets/packing_list_tile.dart';

class PackingListScreen extends StatefulWidget {
  final int id;
  const PackingListScreen({super.key, required this.id});

  @override
  State<PackingListScreen> createState() => _PackingListScreenState();
}

class _PackingListScreenState extends State<PackingListScreen> {
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
                          label: Text("Quantity (Optional)"),
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
                            quantity: quantityController.text.isEmpty
                                ? "1"
                                : quantityController.text,
                            tripId: widget.id,
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
            if (items.value[i].tripId == widget.id) {
              newlist.add(items.value[i]);
            }
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              return PackingListTile(newlist: newlist, index: index);
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
