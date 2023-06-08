import 'package:alquilame/credit_card/bloc/credit_card_bloc.dart';
import 'package:alquilame/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreditCardItem extends StatelessWidget {
  final CreditCardResponse creditCard;
  final ImageProvider image;
  const CreditCardItem(
      {super.key, required this.creditCard, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!creditCard.active!) {
          context
              .read<CreditCardBloc>()
              .add(CreditCardActiveEvent(id: creditCard.id!));
        }
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(40, 20, 40, 20),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromARGB(255, 74, 163, 242),
              Color.fromRGBO(175, 146, 251, 1)
            ],
            stops: [0.3, 0.95],
          ),
          border: Border.all(
            color: creditCard.active! ? Colors.black : Colors.white,
            width: creditCard.active! ? 3 : 0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${creditCard.type}",
                textAlign: TextAlign.right,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      creditCard.number!,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      creditCard.expiredDate!,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      creditCard.holder!,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Image(
                  image: image,
                  height: 50,
                  color: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
      // child: Container(
      //   margin: const EdgeInsets.all(16),
      //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      //   width: double.infinity,
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     border: Border.all(
      //       color: creditCard.active! ? Colors.black : Colors.grey,
      //       width: creditCard.active! ? 4 : 2,
      //     ),
      //     borderRadius: BorderRadius.circular(10),
      //     image:
      //         DecorationImage(opacity: 0.20, fit: BoxFit.cover, image: image),
      //   ),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       Row(
      //         mainAxisSize: MainAxisSize.max,
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: <Widget>[
      //           Text(
      //             creditCard.number!,
      //             style: const TextStyle(
      //                 fontWeight: FontWeight.w700, fontSize: 20),
      //           )
      //         ],
      //       ),
      //       const SizedBox(height: 10),
      //       Row(
      //         mainAxisSize: MainAxisSize.max,
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: <Widget>[
      //           Text(
      //             creditCard.holder!,
      //             style: const TextStyle(
      //                 fontWeight: FontWeight.bold, fontSize: 17),
      //           ),
      //           Text(
      //             creditCard.expiredDate!,
      //             style: const TextStyle(
      //                 fontWeight: FontWeight.bold, fontSize: 17),
      //           ),
      //         ],
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
