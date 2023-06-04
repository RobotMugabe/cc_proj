import 'package:cc_assessment/models/credit_card.dart';
import 'package:cc_assessment/repos/base_repo.dart';

class CreditCardRepo extends BaseRepo<CreditCard> {
  static final CreditCardRepo _instance = CreditCardRepo._internal();

  factory CreditCardRepo() {
    return _instance;
  }

  CreditCardRepo._internal() : super('cards');

  Future<void> init() async => await loadClasses();

  late List<CreditCard> _cards;

  List<CreditCard> get cards => _cards;

  @override
  Future<bool> addClass(CreditCard addClass) async {
    if (!_cards.contains(addClass)) {
      _cards.add(addClass);
      return await super.writeJson(
        _cards.map((CreditCard card) => card.toJson()).toList(),
      );
    } else {
      return false;
    }
  }

  @override
  Future<void> deleteClass(CreditCard removeClass) async {
    _cards.removeWhere((card) => card == removeClass);
    await super.writeJson(_cards.map((CreditCard card) => card.toJson()).toList());
  }

  @override
  Future<void> loadClasses() async {
    List<dynamic> data = await super.readData();
    _cards = data.map((json) => CreditCard.fromJson(json)).toList();
    print('cards loaded');
  }
}


