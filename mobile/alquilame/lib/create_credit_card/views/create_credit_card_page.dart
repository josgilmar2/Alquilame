import 'package:alquilame/config/locator.dart';
import 'package:alquilame/create_credit_card/bloc/create_credit_card_bloc.dart';
import 'package:alquilame/main.dart';
import 'package:alquilame/services/credit_card_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CreateCreditCardPage extends StatelessWidget {
  const CreateCreditCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    CreditCardService _crediCardService = getIt<CreditCardService>();
    return BlocProvider(
      create: (context) => CreateCreditCardBloc(_crediCardService),
      child: const CreateCreditCardSW(),
    );
  }
}

class CreateCreditCardSW extends StatefulWidget {
  const CreateCreditCardSW({
    super.key,
  });

  @override
  State<CreateCreditCardSW> createState() => _CreateCreditCardSWState();
}

class _CreateCreditCardSWState extends State<CreateCreditCardSW> {
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final createCreditCardBloc = context.read<CreateCreditCardBloc>();

    void _onValidate() {
      if (formKey.currentState!.validate()) {
        createCreditCardBloc.submit();
      } else {
        print('invalid!');
      }
    }

    void onCreditCardModelChange(CreditCardModel? creditCardModel) {
      setState(() {
        createCreditCardBloc.number.updateValue(creditCardModel!.cardNumber);
        createCreditCardBloc.expiredDate
            .updateValue(creditCardModel.expiryDate);
        createCreditCardBloc.holder.updateValue(creditCardModel.cardHolderName);
        createCreditCardBloc.cvv.updateValue(creditCardModel.cvvCode);
        isCvvFocused = creditCardModel.isCvvFocused;
      });
    }

    return FormBlocListener<CreateCreditCardBloc, String, String>(
      onSubmitting: (context, state) => CreateCreditCardDialog.show(context),
      onSubmissionFailed: (context, state) {
        SnackBar(
          content: Text(
              "El dígito de comprobación para ${createCreditCardBloc.number.value} no es válido, inténtelo de nuevo. ha fallado la suma de comprobación de Luhn Modulo 10"),
          duration: const Duration(seconds: 5),
        );
      },
      onSuccess: (context, state) {
        CreateCreditCardDialog.hide(context);
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      onFailure: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Recuerda que el número tiene que tener 15 o 16 cifras y que el cvv puede tener 3 o 4 dígitos."),
            duration: Duration(seconds: 7),
          ),
        );
        CreateCreditCardDialog.hide(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("Nuevo método de pago"),
          ),
          backgroundColor: Colors.black87,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            CreditCardWidget(
              cardNumber: createCreditCardBloc.number.value,
              expiryDate: createCreditCardBloc.expiredDate.value,
              cardHolderName: createCreditCardBloc.holder.value,
              cvvCode: createCreditCardBloc.cvv.value,
              bankName: 'Alquilame',
              frontCardBorder: Border.all(color: Colors.grey),
              backCardBorder: Border.all(color: Colors.grey),
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
              isHolderNameVisible: true,
              isSwipeGestureEnabled: true,
              backgroundNetworkImage:
                  'https://png.pngtree.com/thumb_back/fh260/back_our/20190623/ourmid/pngtree-blue-business-atmosphere-business-card-background-image_243064.jpg',
              onCreditCardWidgetChange: (CreditCardBrand brand) {},
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CreditCardForm(
                      cardNumber: createCreditCardBloc.number.value,
                      expiryDate: createCreditCardBloc.expiredDate.value,
                      cardHolderName: createCreditCardBloc.holder.value,
                      cvvCode: createCreditCardBloc.cvv.value,
                      formKey: formKey,
                      obscureCvv: true,
                      isHolderNameVisible: true,
                      isCardNumberVisible: true,
                      isExpiryDateVisible: true,
                      themeColor: Colors.black87,
                      textColor: Colors.black,
                      cardNumberDecoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white60,
                          ),
                        ),
                        labelText: 'Número',
                        hintText: 'XXXX XXXX XXXX XXXX',
                        labelStyle:
                            TextStyle(fontSize: 20, color: Colors.black87),
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        filled: true,
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.black87,
                            width: 1,
                          ),
                        ),
                      ),
                      expiryDateDecoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white60,
                          ),
                        ),
                        labelText: 'Caducidad',
                        hintText: 'XX/XX',
                        labelStyle:
                            TextStyle(fontSize: 20, color: Colors.black87),
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        filled: true,
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.black87,
                            width: 1,
                          ),
                        ),
                      ),
                      cvvCodeDecoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white60,
                          ),
                        ),
                        labelText: 'CVV',
                        hintText: CardType == CardType.americanExpress
                            ? '0000'
                            : '000',
                        labelStyle: const TextStyle(
                            fontSize: 20, color: Colors.black87),
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        filled: true,
                        isDense: true,
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.black87,
                            width: 1,
                          ),
                        ),
                      ),
                      cardHolderDecoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white60,
                          ),
                        ),
                        labelText: 'Titular',
                        labelStyle:
                            TextStyle(fontSize: 20, color: Colors.black87),
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        filled: true,
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.black87,
                            width: 1,
                          ),
                        ),
                      ),
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black87)),
                        child: const Text("Añadir método de pago"),
                        onPressed: () => _onValidate(),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CreateCreditCardDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => CreateCreditCardDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const CreateCreditCardDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
