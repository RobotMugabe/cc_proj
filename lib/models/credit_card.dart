import 'dart:convert';

import 'package:equatable/equatable.dart';

enum CardType { visa, mastercard, amex }

class CreditCard extends Equatable {
  final int cardNumber;
  final CardType ccType;
  final int cvv;
  final String country;
  final String? expiryDate;
  final String? accountHolder;

  const CreditCard({
    required this.cardNumber,
    required this.ccType,
    required this.cvv,
    required this.country,
    this.expiryDate,
    this.accountHolder,
  });

  CreditCard.fromJson(Map<String, dynamic> json)
      : cardNumber = json['card_number'],
        ccType = json['card_type'],
        cvv = json['cvv'],
        country = json['country'],
        expiryDate = json['expiry_date'],
        accountHolder = json['accountHolder'];

  Map<String, dynamic> toJson() => {
        'card_number': cardNumber,
        'card_type': ccType,
        'cvv': cvv,
        'country': country,
        'expiry_date': expiryDate,
        'accountHolder': accountHolder,
      };

  @override
  List<Object?> get props => [
        cardNumber,
        ccType,
        cvv,
        country,
        expiryDate,
        accountHolder,
      ];
}
