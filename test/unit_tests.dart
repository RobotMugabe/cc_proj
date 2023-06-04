import 'package:cc_assessment/models/credit_card.dart';
import 'package:cc_assessment/screens/add_card_screen/add_card_screen.dart';
import 'package:flutter_test/flutter_test.dart';


import 'card_numers.dart';

void main() {

  group('Luhn algorithm tests', () {

    //visa
    test('card number validity tests', () {
      final bool result = luhnAlgorithm(visa[0]);
      expect(result, true);
    });
    test('card number validity tests', () {
      final bool result = luhnAlgorithm(visa[1]);
      expect(result, true);
    });
    test('card number validity tests', () {
      final bool result = luhnAlgorithm(visa[2]);
      expect(result, true);
    });

    //mastercard
    test('card number validity tests', () {
      final bool result = luhnAlgorithm(mastercard[0]);
      expect(result, true);
    });
    test('card number validity tests', () {
      final bool result = luhnAlgorithm(mastercard[1]);
      expect(result, true);
    });
    test('card number validity tests', () {
      final bool result = luhnAlgorithm(mastercard[2]);
      expect(result, true);
    });

    //amex
    test('card number validity tests', () {
      final bool result = luhnAlgorithm(amex[0]);
      expect(result, true);
    });
    test('card number validity tests', () {
      final bool result = luhnAlgorithm(amex[1]);
      expect(result, true);
    });
    test('card number validity tests', () {
      final bool result = luhnAlgorithm(amex[2]);
      expect(result, true);
    });


    //given
    test('card number validity tests', () {
      final bool result = luhnAlgorithm(given[0]);
      expect(result, true);
    });
    test('card number validity tests', () {
      final bool result = luhnAlgorithm(given[1]);
      expect(result, false);
    });
    test('card number validity tests', () {
      final bool result = luhnAlgorithm(given[2]);
      expect(result, false);
    });
    test('card number validity tests', () {
      final bool result = luhnAlgorithm(given[03]);
      expect(result, true);
    });
  });

  group('Card type tests', () {

    //visa
    test('card number validity tests', () {
      final CardType result = getCardTypeFromCardNumber(visa[0]);
      expect(result, CardType.visa);
    });
    test('card number validity tests', () {
      final CardType result = getCardTypeFromCardNumber(visa[1]);
      expect(result, CardType.visa);
    });
    test('card number validity tests', () {
      final CardType result = getCardTypeFromCardNumber(visa[2]);
      expect(result, CardType.visa);
    });

    //mastercard
    test('card number validity tests', () {
      final CardType result = getCardTypeFromCardNumber(mastercard[0]);
      expect(result, CardType.mastercard);
    });
    test('card number validity tests', () {
      final CardType result = getCardTypeFromCardNumber(mastercard[1]);
      expect(result, CardType.mastercard);
    });
    test('card number validity tests', () {
      final CardType result = getCardTypeFromCardNumber(mastercard[2]);
      expect(result, CardType.mastercard);
    });

    //amex
    test('card number validity tests', () {
      final CardType result = getCardTypeFromCardNumber(amex[0]);
      expect(result, CardType.amex);
    });
    test('card number validity tests', () {
      final CardType result = getCardTypeFromCardNumber(amex[1]);
      expect(result, CardType.amex);
    });
    test('card number validity tests', () {
      final CardType result = getCardTypeFromCardNumber(amex[2]);
      expect(result, CardType.amex);
    });


    //given
    test('card number validity tests', () {
      final CardType result = getCardTypeFromCardNumber(given[0]);
      expect(result, CardType.visa);
    });
    test('card number validity tests', () {
      final CardType result = getCardTypeFromCardNumber(given[1]);
      expect(result, CardType.unknown);
    });
    test('card number validity tests', () {
      final CardType result = getCardTypeFromCardNumber(given[2]);
      expect(result, CardType.mastercard);
    });
    test('card number validity tests', () {
      final CardType result = getCardTypeFromCardNumber(given[03]);
      expect(result, CardType.visa);
    });
    
  });
}

