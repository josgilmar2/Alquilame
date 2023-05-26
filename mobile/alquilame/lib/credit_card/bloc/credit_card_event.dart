part of 'credit_card_bloc.dart';

abstract class CreditCardEvent extends Equatable {
  const CreditCardEvent();

  @override
  List<Object> get props => [];
}

class CreditCardInitialEvent extends CreditCardEvent {}

class CreditCardActiveEvent extends CreditCardEvent {
  final int id;

  const CreditCardActiveEvent({required this.id});

  @override
  List<Object> get props => [];
}
