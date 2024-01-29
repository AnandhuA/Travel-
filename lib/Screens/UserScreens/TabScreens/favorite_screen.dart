import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/admin_model.dart';
import 'package:travel/Screens/AdminScreens/place_details_screen.dart';
import 'package:travel/Styles/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.01),
      child: ValueListenableBuilder(
        valueListenable: favplace,
        builder: (context, value, child) {
          return favplace.value.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    PlaceModel favPlace = favplace.value[index];
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.02,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.005,
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: redboderside,
                          ),
                        ),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(15),
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => PlaceDetailsScreen(
                                    index: index,
                                    fav: true,
                                  )),
                            ),
                          );
                        },
                        leading: SizedBox(
                          width: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: favPlace.image[0],
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
                        title: Text(favPlace.place),
                        subtitle: Text(favPlace.district),
                        trailing: IconButton(
                          onPressed: () {
                            removeFavorite(favoritePlace: favPlace.id);
                          },
                          icon: CircleAvatar(
                            radius: 13,
                            backgroundColor: red100,
                            child: const Icon(
                              Icons.favorite,
                              size: 17,
                              color: red,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: screenHeight * 0.02,
                    );
                  },
                  itemCount: favplace.value.length,
                )
              : const Center(
                  child: Text("No Favorite"),
                );
        },
      ),
    );
  }
}
