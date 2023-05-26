import 'package:alquilame/config/locator.dart';
import 'package:alquilame/create_credit_card/views/create_credit_card_page.dart';
import 'package:alquilame/credit_card/bloc/credit_card_bloc.dart';
import 'package:alquilame/services/credit_card_service.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alquilame/credit_card/widgets/credit_card_item.dart';

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({super.key});

  @override
  State<CreditCardPage> createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  @override
  Widget build(BuildContext context) {
    CreditCardService _creditCardService = getIt<CreditCardService>();
    return BlocProvider(
        create: (context) =>
            CreditCardBloc(_creditCardService)..add(CreditCardInitialEvent()),
        child: const CreditCardSF());
  }
}

class CreditCardSF extends StatefulWidget {
  const CreditCardSF({super.key});

  @override
  State<CreditCardSF> createState() => _CreditCardSFState();
}

class _CreditCardSFState extends State<CreditCardSF> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardBloc, CreditCardState>(
      builder: (context, state) {
        if (state is CreditCardSuccess) {
          return CreditCardList(state: state);
        } else if (state is CreditCardFailure) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class CreditCardList extends StatefulWidget {
  final CreditCardSuccess state;
  const CreditCardList({super.key, required this.state});

  @override
  State<CreditCardList> createState() => _CreditCardListState();
}

class _CreditCardListState extends State<CreditCardList> {
  late Image image;

  ImageProvider setCardImg(String type) {
    switch (type) {
      case "VISA":
        return const AssetImage(
          'assets/visa.png',
        );
      case "MASTERCARD":
        return const AssetImage('assets/mastercard.png');
      case "AMERICAN_EXPRESS":
        return const AssetImage('assets/american_express.png');
      case "DISCOVER":
        return const AssetImage('assets/discover.png');
      default:
        return const AssetImage('assets/logo.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateCreditCardPage(),
                ),
              );
            },
          )
        ],
        title: const Center(
          child: Text("Métodos de pago"),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CreditCardItem(
                    creditCard: widget.state.creditCards[index],
                    image: setCardImg(widget.state.creditCards[index].type!),
                  );
                },
                itemCount: widget.state.creditCards.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
