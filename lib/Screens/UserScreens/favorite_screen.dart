import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel/Functions/user_functions.dart';
import 'package:travel/Models/user_model.dart';
import 'package:travel/Screens/AdminScreens/place_details_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ValueListenableBuilder(
        valueListenable: favoriteList,
        builder: (context, value, child) {
          return favoriteList.value.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    FavoriteModel favPlace = favoriteList.value[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(138, 255, 155, 147),
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
                          width: 110,
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
                            backgroundColor: Colors.red.shade100,
                            child: const Icon(
                              Icons.favorite,
                              size: 17,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 30,
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
