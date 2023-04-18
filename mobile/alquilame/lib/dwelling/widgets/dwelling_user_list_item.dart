import 'package:alquilame/dwelling/dwelling.dart';
import 'package:alquilame/dwelling_detail/dwelling_detail.dart';
import 'package:alquilame/models/models.dart';
import 'package:flutter/material.dart';

class DwellingUserListItem extends StatefulWidget {
  final Dwelling dwelling;
  final DwellingBloc dwellingBloc;

  DwellingUserListItem({required this.dwelling, required this.dwellingBloc});

  @override
  _DwellingUserListItemState createState() => _DwellingUserListItemState();
}

class _DwellingUserListItemState extends State<DwellingUserListItem> {
  bool _isDeleting = false;

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
                  image: NetworkImage(widget.dwelling.image == null
                      ? "https://areajugones.sport.es/wp-content/uploads/2020/12/zoneri-021-headquarters-garrison.jpg"
                      : "http://localhost:8080/download/${widget.dwelling.image}"),
                  height: 240,
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DwellingDetailPage(id: widget.dwelling.id),
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
                              widget.dwelling.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "4,8",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Icon(
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
                          "${widget.dwelling.price} €",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.dwelling.province,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 24,
                              ),
                              tooltip: 'ELIMINAR',
                              onPressed: () => _showDeleteConfirmationDialog(
                                  context, widget.dwellingBloc),
                            ),
                          ],
                        )
                      ],
                    )))
          ],
        ));
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, DwellingBloc dwellingBloc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Quiéres eliminar esta vivienda de tu lista?'),
          content: const Text('Recuerda que esta acción no se puede deshacer.'),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('ELIMINAR'),
              onPressed: () async {
                setState(() {
                  _isDeleting = true;
                });

                dwellingBloc.add(DwellingDelete(id: widget.dwelling.id));

                /*setState(() {
                  _isDeleting = false;
                });*/

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "Se ha eliminado correctamente la vivienda de tu lista. Para comprobarlo sal de la lista y vuelve a entrar")));
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DwellingUserListPage(),
                    ));
              },
            ),
          ],
        );
      },
    );
  }
}
