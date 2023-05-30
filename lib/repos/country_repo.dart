import 'package:cc_assessment/models/country.dart';
import 'package:cc_assessment/repos/base_repo.dart';

class CountryRepo extends BaseRepo<Country>{
  static final CountryRepo _instance = CountryRepo._internal();

  factory CountryRepo() {
    return _instance;
  }

  CountryRepo._internal() : super('countries');

  Future<void> init() async => await loadClasses();

  late List<Country> _countries;

  List<Country> get countries => _countries;

  @override
  Future<bool> addClass(Country addClass) async {
    if (!_countries.contains(addClass)) {
      _countries.add(addClass);
      return await super.writeJson(
        _countries.map((Country country) => country.toJson()).toList(),
        isInitial: _countries.length == 1,
      );
    } else {
      return false;
    }
  }

  @override
  Future<void> deleteClass(Country removeClass) async {
    _countries.removeWhere((country) => country == removeClass);
    await super.writeJson(_countries.map((Country country) => country.toJson()).toList(), isInitial: true);
  }

  @override
  Future<void> loadClasses() async {
    List<dynamic> data = await super.readData();
    _countries = data.map((json) => Country.fromJson(json)).toList();
  }
}