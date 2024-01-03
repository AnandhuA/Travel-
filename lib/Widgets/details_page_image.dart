import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel/Models/model.dart';

class DetailsPageImage extends StatefulWidget {
  final PlaceModel place;
  const DetailsPageImage({super.key, required this.place});

  @override
  State<DetailsPageImage> createState() => _DetailsPageImageState();
}

class _DetailsPageImageState extends State<DetailsPageImage> {
  int photo = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 400,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
                child: Image.file(
                  File(widget.place.image[photo]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: SafeArea(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.place.image.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          photo = index;
                        });
                      },
                      child: index == photo
                          ? Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 3),
                              ),
                              child: Image.file(
                                File(widget.place.image[index]),
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.file(
                              File(widget.place.image[index]),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
