part of 'card_screen_cubit.dart';

class CardScreenState extends Equatable {
  final List<CreditCard> creditCards;
  
  CardScreenState._(this.creditCards);

  CardScreenState.initial(): this._([]);

  @override
  List<Object?> get props => [...creditCards];
}
