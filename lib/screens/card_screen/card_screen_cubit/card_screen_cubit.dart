import 'package:bloc/bloc.dart';
import 'package:cc_assessment/models/credit_card.dart';
import 'package:cc_assessment/repos/credit_card_repo.dart';
import 'package:equatable/equatable.dart';

part 'card_screen_state.dart';

class CardScreenCubit extends Cubit<CardScreenState> {

  CardScreenCubit() : super(CardScreenState.initial());

  Future<void> loadCards() async {
    emit(
      CardScreenState.loaded(CreditCardRepo().cards),
    );
  }

  Future<void> addCard(CreditCard card) async {
    final bool isSaved = await CreditCardRepo().addClass(card);
    if (isSaved) {
      emit(
        CardScreenState.loaded(state.creditCards..add(card)),
      );
    }
  }

  Future<void> deleteCard(CreditCard card) async {
    await CreditCardRepo().deleteClass(card);
    emit(
      CardScreenState.loaded(CreditCardRepo().cards),
    );
  }
}
