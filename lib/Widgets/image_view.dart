import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:travel/Styles/colors.dart';

class ImageView extends StatelessWidget {
  final List<String> image;
  final int initialIndex;
  final bool local;
 

  const ImageView({
    super.key,
    required this.image,
    required this.initialIndex,
    this.local = false,
  
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: PhotoViewGallery.builder(
        itemCount: image.length,
        builder: (context, index) {
          return local
              ? PhotoViewGalleryPageOptions(
                  imageProvider: FileImage(File(image[index])),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  heroAttributes: PhotoViewHeroAttributes(tag: index),
                )
              : PhotoViewGalleryPageOptions(
                  imageProvider: CachedNetworkImageProvider(image[index]),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  heroAttributes: PhotoViewHeroAttributes(tag: index),
                );
        },
        backgroundDecoration: const BoxDecoration(
          color: black,
        ),
        pageController: PageController(initialPage: initialIndex),
      ),
    );
  }
}
