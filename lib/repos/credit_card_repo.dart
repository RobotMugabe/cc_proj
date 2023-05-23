import 'dart:convert';
import 'dart:io';

import 'package:cc_assessment/models/credit_card.dart';
import 'package:path_provider/path_provider.dart';

class CreditCardRepo {
  static final CreditCardRepo _instance = CreditCardRepo._internal();

  factory CreditCardRepo() {
    return _instance;
  }

  CreditCardRepo._internal() {
    _loadCreditCards();
  }

  late List<CreditCard> _cards;

  List<CreditCard> get cards => _cards;

  Future<bool> addCard(CreditCard card) async {
    if (!_cards.contains(card)) {
      _cards.add(card);
      return await _writeCardJson(
        _cards.map((CreditCard card) => card.toJson()).toList(),
        isInitial: _cards.length == 1,
      );
    } else {
      return false;
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _loadFile async {
    final path = await _localPath;
    return File('$path/cards.txt');
  }

  Future<bool> _writeCardJson(dynamic cardJson, {required bool isInitial}) async {
    final file = await _loadFile;
    try {
      await file.writeAsString(
        jsonEncode(cardJson),
        mode: isInitial ? FileMode.write : FileMode.append,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<dynamic>> _readData() async {
    try {
      final file = await _loadFile;
      final contents = await file.readAsString();
      return jsonDecode(contents) as List<dynamic>;
    } catch (e) {
      return [];
    }
  }

  Future<void> _loadCreditCards() async {
    List<dynamic> data = await _readData();
    _cards = data.map((json) => CreditCard.fromJson(json)).toList();
  }
}
