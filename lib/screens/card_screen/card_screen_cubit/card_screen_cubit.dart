import 'package:bloc/bloc.dart';
import 'package:cc_assessment/models/credit_card.dart';
import 'package:cc_assessment/repos/credit_card_repo.dart';
import 'package:equatable/equatable.dart';

part 'card_screen_state.dart';

class CardScreenCubit extends Cubit<CardScreenState> {
  late CreditCardRepo cardRepo;
  CardScreenCubit() : super(CardScreenState.initial()) {
    cardRepo = CreditCardRepo();
  }

  Future<void> loadCards() async {
    await cardRepo.init();
    emit(
      CardScreenState.loaded(cardRepo.cards),
    );
  }

  Future<void> addCard(CreditCard card) async {
    await cardRepo.addClass(card);
    emit(
      CardScreenState.loaded(state.creditCards..add(card)),
    );
  }

  Future<void> deleteCard(CreditCard card) async {
    await cardRepo.deleteClass(card);
    emit(
      CardScreenState.loaded(cardRepo.cards),
    );
  }
}
