import 'package:cc_assessment/models/base_class.dart';

enum CardType { visa, mastercard, amex, unknown }

CardType getCardType(String cardType) {
  if (cardType.toLowerCase() == CardType.visa.name.toString()) {
    return CardType.visa;
  } else if (cardType.toLowerCase() == CardType.mastercard.name.toString()) {
    return CardType.mastercard;
  } else if (cardType.toLowerCase() == CardType.amex.name.toString()) {
    return CardType.amex;
  }
  return CardType.unknown;
}

bool masterCardMatcher(String cardNumber) {
  if (cardNumber.startsWith('51')) {
    return true;
  } else if (cardNumber.startsWith('52')) {
    return true;
  } else if (cardNumber.startsWith('53')) {
    return true;
  } else if (cardNumber.startsWith('54')) {
    return true;
  } else if (cardNumber.startsWith('55')) {
    return true;
  } else if ((int.parse(cardNumber.substring(0, 6)) >= 222100) &&
      (int.parse(cardNumber.substring(0, 6)) <= 272099)) {
    return true;
  }
  return false;
}

CardType getCardTypeFromCardNumber(String cardNumber) {
  if (cardNumber.startsWith('4')) {
    return CardType.visa;
  } else if (masterCardMatcher(cardNumber)) {
    return CardType.mastercard;
  } else if (cardNumber.startsWith('34') || cardNumber.startsWith('37')) {
    return CardType.amex;
  }
  return CardType.unknown;
}

class CreditCard extends BaseClass {
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

  //break card number up into chunks of 4
  String get friendlyCardNumber {
    String returnString = '';
    for (int i = 0; i <= cardNumber.toString().length; i += 4) {
      if (cardNumber.toString().length < i + 4) {
        returnString += cardNumber.toString().substring(i);
        break;
      }
      returnString += '${cardNumber.toString().substring(i, i + 4)} ';
    }
    return returnString;
  }

  CreditCard.fromJson(Map<String, dynamic> json)
      : cardNumber = json['card_number'],
        ccType = getCardType(json['card_type']),
        cvv = json['cvv'],
        country = json['country'],
        expiryDate = json['expiry_date'],
        accountHolder = json['accountHolder'];

  Map<String, dynamic> toJson() => {
        'card_number': cardNumber,
        'card_type': ccType.name.toString(),
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
      ];
}
