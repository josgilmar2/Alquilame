import 'dart:convert';

import 'package:alquilame/create_rental/views/create_rental_page.dart';
import 'package:alquilame/dwelling/dwelling.dart';
import 'package:alquilame/dwelling_detail/dwelling_detail.dart';
import 'package:alquilame/favourite/favourite.dart';
import 'package:alquilame/models/models.dart';
import 'package:alquilame/rest/rest_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:like_button/like_button.dart';

class DwellingDetailScreen extends StatefulWidget {
  final OneDwellingResponse? dwellingDetail;
  final UserResponse? userResponse;
  final BuildContext superContext;

  const DwellingDetailScreen(
      {super.key,
      required this.dwellingDetail,
      required this.userResponse,
      required this.superContext});

  @override
  State<DwellingDetailScreen> createState() => _DwellingDetailScreenState();
}

class _DwellingDetailScreenState extends State<DwellingDetailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double rating = 1.0;
  final comentarioController = TextEditingController();

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
                      : "${ApiConstants.baseUrl}/download/${widget.dwellingDetail?.image}",
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
                    widget.dwellingDetail?.owner?.id == widget.userResponse?.id
                        ? const SizedBox()
                        : LikeButton(
                            onTap: (isLiked) {
                              if (isLiked) {
                                return unlike(widget.dwellingDetail!, isLiked);
                              }
                              return like(widget.dwellingDetail!, isLiked);
                            },
                            isLiked: widget.dwellingDetail?.like,
                            likeBuilder: (isLiked) {
                              var color = isLiked ? Colors.red : Colors.white;
                              return Icon(
                                Icons.favorite,
                                color: color,
                                size: 25,
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
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "${widget.dwellingDetail?.averageScore?.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    widget.dwellingDetail?.owner?.id ==
                                            widget.userResponse?.id
                                        ? const Icon(
                                            Icons.star,
                                            color: Colors.black,
                                          )
                                        : IconButton(
                                            color: Colors.black,
                                            icon: const Icon(Icons.star),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      "Valora ${widget.dwellingDetail?.name}",
                                                    ),
                                                    content: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Form(
                                                          key: _formKey,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            5,
                                                                        top: 40,
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                child: Center(
                                                                  child: RatingBar
                                                                      .builder(
                                                                    initialRating:
                                                                        3,
                                                                    minRating:
                                                                        1,
                                                                    direction: Axis
                                                                        .horizontal,
                                                                    allowHalfRating:
                                                                        true,
                                                                    itemCount:
                                                                        5,
                                                                    itemPadding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            4.0),
                                                                    itemBuilder:
                                                                        (context,
                                                                                _) =>
                                                                            const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    onRatingUpdate:
                                                                        (newRating) {
                                                                      rating =
                                                                          newRating;
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(20),
                                                                child:
                                                                    TextFormField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .multiline,
                                                                  maxLines:
                                                                      null,
                                                                  controller:
                                                                      comentarioController,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    hintText:
                                                                        'Dinos tu opinión',
                                                                    labelText:
                                                                        'Comentario',
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: const Text(
                                                          "Cancelar",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          widget.superContext
                                                              .read<
                                                                  DwellingDetailBloc>()
                                                              .add(RateEvent(
                                                                  widget
                                                                      .dwellingDetail!
                                                                      .id,
                                                                  rating,
                                                                  comentarioController
                                                                      .text));
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'Valorar',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
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
                      widget.dwellingDetail?.owner?.id ==
                              widget.userResponse?.id
                          ? const SizedBox()
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                    horizontal: 32.0,
                                  ),
                                ),
                                child: const Text(
                                  "Alquilar ahora",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreateRentalPage(
                                        dwellingResponse: widget.dwellingDetail,
                                      ),
                                    ),
                                  );
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
                                                : "${ApiConstants.baseUrl}/download/${widget.dwellingDetail?.owner?.avatar}"))),
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

  Future<bool> like(OneDwellingResponse dwelling, bool bool) async {
    context.read<FavouriteBloc>().add(AddFavourite(dwelling.id));
    return !bool;
  }

  Future<bool> unlike(OneDwellingResponse dwelling, bool bool) async {
    context.read<FavouriteBloc>().add(DeleteFavourite(dwelling.id));
    return !bool;
  }
}
