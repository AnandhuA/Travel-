import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Screens/AdminScreens/place_details_screen.dart';
import 'package:travel/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.01),
      child: ValueListenableBuilder(
        valueListenable: favoriteList,
        builder: (context, value, child) {
          return favoriteList.value.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    FavoriteModel favPlace = favoriteList.value[index];
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02),
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.005),
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
                            child: Image.file(
                              File(favPlace.favoritePlace.image[0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(favPlace.favoritePlace.place),
                        subtitle: Text(favPlace.favoritePlace.district),
                        trailing: IconButton(
                          onPressed: () {
                            removeFavorite(favoritePlace: favPlace);
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
                  itemCount: favoriteList.value.length,
                )
              : const Center(
                  child: Text("No Favorite"),
                );
        },
      ),
    );
  }
}
