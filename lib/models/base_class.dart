import 'package:equatable/equatable.dart';

abstract class BaseClass extends Equatable {
  const BaseClass();
  @override
  List<Object?> get props;
}
