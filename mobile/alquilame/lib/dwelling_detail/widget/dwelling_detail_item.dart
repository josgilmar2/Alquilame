import 'package:alquilame/dwelling_detail/dwelling_detail.dart';
import 'package:alquilame/dwelling_favourite/dwelling_favourite.dart';
import 'package:alquilame/favourite/favourite.dart';
import 'package:alquilame/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DwellingDetailItem extends StatelessWidget {
  const DwellingDetailItem({super.key, required this.dwellingDetail});

  final OneDwellingResponse? dwellingDetail;

  @override
  Widget build(BuildContext context) {
    bool isFavorited = context
        .select((DwellingFavouritesBloc bloc) => _isFavorited(bloc.state));
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
                  dwellingDetail?.image == null
                      ? "https://areajugones.sport.es/wp-content/uploads/2020/12/zoneri-021-headquarters-garrison.jpg"
                      : "http://localhost:8080/download/${dwellingDetail?.image}",
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
                    "${dwellingDetail?.name}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
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
                        "${dwellingDetail?.address}",
                        style: const TextStyle(
                            color: Colors.white, fontSize: 13.0),
                      ),
                    ),
                    const Spacer(),
                    BlocBuilder<FavouriteBloc, FavouriteState>(
                      builder: (context, state) {
                        switch (state.status) {
                          case FavouriteStatus.success:
                            return IconButton(
                              color: Colors.white,
                              icon: const Icon(Icons.favorite_outline),
                              onPressed: () async {
                                BlocProvider.of<FavouriteBloc>(context)
                                    .add(AddFavourite(dwellingDetail!.id));
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DwellingDetailPage(
                                          id: dwellingDetail!.id),
                                    ));
                              },
                            );
                          case FavouriteStatus.initial:
                            return IconButton(
                              color: Colors.white,
                              icon: const Icon(Icons.favorite_outline),
                              onPressed: () async {
                                //
                              },
                            );
                          case FavouriteStatus.failure:
                            return IconButton(
                              color: Colors.white,
                              icon: const Icon(Icons.favorite),
                              onPressed: () async {
                                BlocProvider.of<FavouriteBloc>(context)
                                    .add(DeleteFavourite(dwellingDetail!.id));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      "Vivienda eliminada de favoritos correctamente."),
                                  duration: Duration(seconds: 4),
                                ));
                              },
                            );
                        }
                      },
                    ),
                  ],
                ),
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
                                        text: "${dwellingDetail?.province}"),
                                    const WidgetSpan(
                                      child: SizedBox(
                                        width: 10.0,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: Icon(
                                        dwellingDetail?.hasElevator == true
                                            ? Icons.elevator
                                            : Icons.elevator_outlined,
                                        size: 16.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: Icon(
                                        dwellingDetail?.hasPool == true
                                            ? Icons.pool
                                            : Icons.pool_outlined,
                                        size: 16.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: Icon(
                                        dwellingDetail?.hasTerrace == true
                                            ? Icons.balcony
                                            : Icons.balcony_outlined,
                                        size: 16.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: Icon(
                                        dwellingDetail?.hasGarage == true
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
                                "${dwellingDetail?.price} €",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text(
                                "${dwellingDetail?.m2} m²",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                "${dwellingDetail?.numBedrooms} habitaciones",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                "${dwellingDetail?.numBathrooms} baños",
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
                        "${dwellingDetail?.description}",
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
                                            image: NetworkImage(dwellingDetail
                                                        ?.owner?.avatar ==
                                                    null
                                                ? "https://e7.pngegg.com/pngimages/323/705/png-clipart-user-profile-get-em-cardiovascular-disease-zingah-avatar-miscellaneous-white.png"
                                                : "http://localhost:8080/download/${dwellingDetail?.owner?.avatar}"))),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "${dwellingDetail?.owner?.fullName}",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    Text(
                                      "${dwellingDetail?.owner?.phoneNumber}",
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
                                        "${dwellingDetail?.owner?.numPublications}",
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

  bool _isFavorited(DwellingFavouritesState state) {
    return state.dwellings.contains(dwellingDetail);
  }
}
