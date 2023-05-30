import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_card_screen_state.dart';

class AddCardScreenCubit extends Cubit<AddCardScreenState> {
  AddCardScreenCubit() : super(AddCardScreenInitial());
}
