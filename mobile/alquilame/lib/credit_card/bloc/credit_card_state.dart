part of 'credit_card_bloc.dart';

abstract class CreditCardState extends Equatable {
  const CreditCardState();

  @override
  List<Object> get props => [];
}

class CreditCardInitial extends CreditCardState {}

class CreditCardSuccess extends CreditCardState {
  final List<CreditCardResponse> creditCards;

  const CreditCardSuccess({required this.creditCards});

  @override
  List<Object> get props => [creditCards];
}

class CreditCardFailure extends CreditCardState {
  final String error;

  const CreditCardFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class CreditCardLoading extends CreditCardState {}
