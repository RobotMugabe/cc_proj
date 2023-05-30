part of 'card_screen_cubit.dart';

class CardScreenState extends Equatable {
  final List<CreditCard> creditCards;

  const CardScreenState._(this.creditCards);

  CardScreenState.initial() : this._([]);

  const CardScreenState.loaded(List<CreditCard> cards) : this._(cards);

  @override
  List<Object?> get props => [...creditCards];
}
