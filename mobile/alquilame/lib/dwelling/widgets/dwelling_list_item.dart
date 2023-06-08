import 'package:alquilame/dwelling_detail/views/dwelling_detail_page.dart';
import 'package:alquilame/models/models.dart';
import 'package:flutter/material.dart';

class DwellingListItem extends StatelessWidget {
  const DwellingListItem({Key? key, required this.dwelling}) : super(key: key);

  final Dwelling dwelling;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Ink.image(
                  image: NetworkImage(dwelling.image == null
                      ? "https://areajugones.sport.es/wp-content/uploads/2020/12/zoneri-021-headquarters-garrison.jpg"
                      : "http://localhost:8080/download/${dwelling.image}"),
                  height: 240,
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DwellingDetailPage(id: dwelling.id),
                          ));
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dwelling.name,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                dwelling.averageScore.toStringAsFixed(2),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.black,
                                size: 16,
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${dwelling.price} €",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        dwelling.province,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}
