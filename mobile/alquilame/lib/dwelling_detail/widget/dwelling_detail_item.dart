import 'dart:convert';

import 'package:alquilame/dwelling/dwelling.dart';
import 'package:alquilame/dwelling_detail/dwelling_detail.dart';
import 'package:alquilame/favourite/favourite.dart';
import 'package:alquilame/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DwellingDetailScreen extends StatefulWidget {
  final OneDwellingResponse? dwellingDetail;
  final UserResponse? userResponse;

  const DwellingDetailScreen(
      {super.key, required this.dwellingDetail, required this.userResponse});

  @override
  State<DwellingDetailScreen> createState() => _DwellingDetailScreenState();
}

class _DwellingDetailScreenState extends State<DwellingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "Detalle",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Container(
              foregroundDecoration: const BoxDecoration(color: Colors.black26),
              height: 400,
              child: Image.network(
                  widget.dwellingDetail?.image == null
                      ? "https://areajugones.sport.es/wp-content/uploads/2020/12/zoneri-021-headquarters-garrison.jpg"
                      : "http://localhost:8080/download/${widget.dwellingDetail?.image}",
                  fit: BoxFit.cover)),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "${widget.dwellingDetail?.name}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 16.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text(
                        "${widget.dwellingDetail?.address}",
                        style: const TextStyle(
                            color: Colors.white, fontSize: 13.0),
                      ),
                    ),
                    const Spacer(),
                    BlocBuilder<FavouriteBloc, FavouriteState>(
                      key: UniqueKey(),
                      builder: (context, state) {
                        bool isFavourite = state.isFavourite;
                        if (widget.dwellingDetail?.owner?.id ==
                            widget.userResponse?.id) {
                          return const SizedBox();
                        }
                        print("isFavourite: $isFavourite");
                        return IconButton(
                          color: Colors.white,
                          icon: isFavourite
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_outline),
                          onPressed: () {
                            if (!isFavourite) {
                              BlocProvider.of<FavouriteBloc>(context)
                                  .add(AddFavourite(widget.dwellingDetail!.id));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    "Vivienda añadida de favoritos correctamente."),
                                duration: Duration(seconds: 4),
                              ));
                            } else {
                              BlocProvider.of<FavouriteBloc>(context).add(
                                  DeleteFavourite(widget.dwellingDetail!.id));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    "Vivienda eliminada de favoritos correctamente."),
                                duration: Duration(seconds: 4),
                              ));
                            }
                            setState(() {
                              isFavourite = !isFavourite;
                            });
                          },
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(32.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: Colors.black,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.black,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.black,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.black,
                                    ),
                                    Icon(
                                      Icons.star_border,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                Text.rich(
                                  TextSpan(children: [
                                    const WidgetSpan(
                                        child: Icon(
                                      Icons.location_on,
                                      size: 16.0,
                                      color: Colors.grey,
                                    )),
                                    TextSpan(
                                        text:
                                            "${widget.dwellingDetail?.province}"),
                                    const WidgetSpan(
                                      child: SizedBox(
                                        width: 10.0,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: Icon(
                                        widget.dwellingDetail?.hasElevator ==
                                                true
                                            ? Icons.elevator
                                            : Icons.elevator_outlined,
                                        size: 16.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: Icon(
                                        widget.dwellingDetail?.hasPool == true
                                            ? Icons.pool
                                            : Icons.pool_outlined,
                                        size: 16.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: Icon(
                                        widget.dwellingDetail?.hasTerrace ==
                                                true
                                            ? Icons.balcony
                                            : Icons.balcony_outlined,
                                        size: 16.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: Icon(
                                        widget.dwellingDetail?.hasGarage == true
                                            ? Icons.garage
                                            : Icons.garage_outlined,
                                        size: 16.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ]),
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "${widget.dwellingDetail?.price} €",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text(
                                "${widget.dwellingDetail?.m2} m²",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                "${widget.dwellingDetail?.numBedrooms} habitaciones",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                "${widget.dwellingDetail?.numBathrooms} baños",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 32.0,
                            ),
                          ),
                          child: const Text(
                            "Alquilar ahora",
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                          onPressed: () {
                            //ESTO SE HARÁ EN EL PROYECTO FINAL
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Text(
                        "Description".toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "${widget.dwellingDetail?.description}",
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 14.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Owner".toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14.0),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          color: Colors.black87,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(widget
                                                        .dwellingDetail
                                                        ?.owner
                                                        ?.avatar ==
                                                    null
                                                ? "https://e7.pngegg.com/pngimages/323/705/png-clipart-user-profile-get-em-cardiovascular-disease-zingah-avatar-miscellaneous-white.png"
                                                : "http://localhost:8080/download/${widget.dwellingDetail?.owner?.avatar}"))),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "${widget.dwellingDetail?.owner?.fullName}",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    Text(
                                      "${widget.dwellingDetail?.owner?.phoneNumber}",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${widget.dwellingDetail?.owner?.numPublications}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        "publications",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
