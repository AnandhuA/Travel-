// full_screen_image_page.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:travel/Styles/colors.dart';

class ImageView extends StatelessWidget {
  final List<String> image;
  final int initialIndex;

  const ImageView({
    super.key,
    required this.image,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
        itemCount: image.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
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
