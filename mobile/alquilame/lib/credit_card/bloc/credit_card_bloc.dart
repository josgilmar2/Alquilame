import 'package:alquilame/credit_card/widgets/credit_card_colors.dart';
import 'package:alquilame/models/credit_card.dart';
import 'package:alquilame/services/credit_card_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'credit_card_event.dart';
part 'credit_card_state.dart';

class CreditCardBloc extends Bloc<CreditCardEvent, CreditCardState> {
  final CreditCardService _creditCardService;

  CreditCardBloc(CreditCardService creditCardService)
      : assert(creditCardService != null),
        _creditCardService = creditCardService,
        super(CreditCardInitial()) {
    on<CreditCardInitialEvent>(_onCreditCardInitialEvent);
    on<CreditCardActiveEvent>(_onCreditCardActiveEvent);
  }

  Future<void> _onCreditCardInitialEvent(
      CreditCardInitialEvent event, Emitter<CreditCardState> emit) async {
    try {
      List<CreditCardResponse> creditCards =
          await _creditCardService.getAllUserCreditCards();
      emit(CreditCardSuccess(creditCards: creditCards));
    } catch (e) {
      emit(CreditCardFailure(error: e.toString()));
    }
  }

  Future<void> _onCreditCardActiveEvent(
      CreditCardActiveEvent event, Emitter<CreditCardState> emit) async {
    try {
      CreditCardResponse toActive =
          await _creditCardService.activateCreditCard(event.id);
      List<CreditCardResponse> creditCards =
          await _creditCardService.getAllUserCreditCards();
      emit(CreditCardSuccess(creditCards: creditCards));
    } catch (e) {
      emit(CreditCardFailure(error: e.toString()));
    }
  }
}
