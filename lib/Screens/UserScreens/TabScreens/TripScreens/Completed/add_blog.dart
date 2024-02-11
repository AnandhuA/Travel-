import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Styles/colors.dart';
import 'package:travel/Widgets/button.dart';

class AddBlogScreen extends StatefulWidget {
  final TripModel trip;
  final CompletedTripModelBlog? blog;
  const AddBlogScreen({super.key, required this.trip, this.blog});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final TextEditingController aboutTripController = TextEditingController();
  @override
  void initState() {
    widget.blog != null ? aboutTripController.text = widget.blog!.blog : "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String day = DateFormat('dd').format(trip.rangeStart);
    // String week = DateFormat('EEE').format(trip.rangeStart);
    String start = DateFormat('dd MMM yyyy').format(widget.trip.rangeStart);
    String end = DateFormat('dd MMM yyyy').format(widget.trip.rangeEnd);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("To ${widget.trip.destination}"),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(widget.trip.description),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text("Start on $start to $end"),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text("Type ${widget.trip.travelType}"),
              SizedBox(
                height: size.height * 0.02,
              ),
              TextField(
                controller: aboutTripController,
                minLines: 1,
                maxLines: 100,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: const Text("Write About Trip"),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              addButton(
                  onpress: () async {
                    if (aboutTripController.text.isNotEmpty) {
                      await addBlog(
                        blog: CompletedTripModelBlog(
                          id: widget.blog != null
                              ? widget.blog!.id
                              : DateTime.now()
                                  .microsecondsSinceEpoch
                                  .toString(),
                          blog: aboutTripController.text,
                          tripId: widget.trip.id,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  color: blue300)
            ],
          ),
        ),
      ),
    );
  }
}
