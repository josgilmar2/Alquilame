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
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: creditCard.active! ? Colors.black : Colors.grey,
            width: creditCard.active! ? 4 : 2,
          ),
          borderRadius: BorderRadius.circular(10),
          image:
              DecorationImage(opacity: 0.20, fit: BoxFit.cover, image: image),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  creditCard.number!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 20),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  creditCard.holder!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Text(
                  creditCard.expiredDate!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
