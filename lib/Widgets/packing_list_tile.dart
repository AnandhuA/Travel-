import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Styles/colors.dart';

class PackingListTile extends StatefulWidget {
  final List<PackingListModel> newlist;
  final int index;
  const PackingListTile(
      {super.key, required this.newlist, required this.index});

  @override
  State<PackingListTile> createState() => _PackingListTileState();
}

class _PackingListTileState extends State<PackingListTile> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(widget.newlist[widget.index].id.toString()),
      // startActionPane: ActionPane(
      //   extentRatio: 0.25,
      //   motion: const Padding(
      //     padding: EdgeInsets.all(5.0),
      //     child: StretchMotion(),
      //   ),
      //   children: [
      //     SlidableAction(
      //       borderRadius: BorderRadius.circular(15),
      //       backgroundColor: red50,
      //       autoClose: true,
      //       onPressed: (context) {
      //         ScaffoldMessenger.of(context)
      //             .showSnackBar(const SnackBar(
      //           duration: Duration(seconds: 1),
      //           content: Text("Delete successfully"),
      //           backgroundColor: black,
      //         ));
      //         delectPackingIteam(
      //           packingModel: newlist[index],
      //         );
      //       },
      //       foregroundColor: red,
      //       icon: Icons.delete,
      //       label: "Delect",
      //     ),
      //   ],
      // ),
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
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(seconds: 1),
                content: Text("Delete successfully"),
                backgroundColor: black,
              ));
              delectPackingIteam(
                packingModel: widget.newlist[widget.index],
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
          onTap: () {
            setState(() {
              widget.newlist[widget.index].check =
                  !widget.newlist[widget.index].check;
              addPackingItems(
                packingModel: PackingListModel(
                  id: widget.newlist[widget.index].id,
                  item: widget.newlist[widget.index].item,
                  tripId: widget.newlist[widget.index].tripId,
                  quantity: widget.newlist[widget.index].quantity,
                  check: widget.newlist[widget.index].check,
                ),
              );
            });
          },
          title: Text(
            "${widget.newlist[widget.index].item} (${widget.newlist[widget.index].quantity})",
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
                    id: widget.newlist[widget.index].id,
                    item: widget.newlist[widget.index].item,
                    tripId: widget.newlist[widget.index].tripId,
                    quantity: widget.newlist[widget.index].quantity,
                    check: value,
                  ),
                );
              }
            },
            value: widget.newlist[widget.index].check,
          ),
          tileColor: widget.newlist[widget.index].check ? green50 : red50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
