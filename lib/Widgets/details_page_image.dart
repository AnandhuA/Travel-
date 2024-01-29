import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/admin_model.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Widgets/image_view.dart';
import 'package:travel/Styles/colors.dart';
import 'package:travel/main.dart';

class DetailsPageImage extends StatefulWidget {
  // final PlaceModel place;
  final PlaceModel place;
  final BuildContext ctx;
  const DetailsPageImage({super.key, required this.place, required this.ctx});

  @override
  State<DetailsPageImage> createState() => _DetailsPageImageState();
}

class _DetailsPageImageState extends State<DetailsPageImage> {
  bool favorite = false;
  @override
  void initState() {
    super.initState();
    for (final fav in favplace.value) {
      if (fav.id == widget.place.id) {
        favorite = true;
      }
    }
  }

  int photo = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 400,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    photo = index;
                  });
                },
              ),
              items: widget.place.image.map((imagePath) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageView(
                          image: widget.place.image,
                          initialIndex: photo,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.place.image[photo],
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: purple100,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
            admin
                ? const SizedBox()
                : Positioned(
                    right: 30,
                    child: SafeArea(
                      child: Row(
                        children: [
                          // CircleAvatar(
                          //   backgroundColor:
                          //       const Color.fromARGB(100, 255, 255, 255),
                          //   child: IconButton(
                          //     onPressed: () {},
                          //     icon: const Icon(Icons.share),
                          //   ),
                          // ),
                          const SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            backgroundColor: transperantcolor,
                            child: IconButton(
                              onPressed: () {
                                favorite
                                    ? setState(() {
                                        favorite = false;
                                      })
                                    : setState(() {
                                        favorite = true;
                                      });
                                FavoriteModel fav = FavoriteModel(
                                  id: widget.place.id,
                                  favoritePlace: widget.place.id,
                                  uid: FirebaseAuth.instance.currentUser!.uid
                                      .toString(),
                                );
                                favorite
                                    ? addFavorite(favoritePlace: fav)
                                    : removeFavorite(
                                        favoritePlace: widget.place.id);
                              },
                              icon: favorite
                                  ? const Icon(
                                      Icons.favorite,
                                      color: red,
                                    )
                                  : const Icon(Icons.favorite_border),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            Positioned(
              left: 10,
              child: SafeArea(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(widget.ctx);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
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
                                    Border.all(color: borderColor, width: 3),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: widget.place.image[index],
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: purple100,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: widget.place.image[index],
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                  color: purple100,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
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
