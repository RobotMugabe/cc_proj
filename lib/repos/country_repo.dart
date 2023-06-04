import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:cc_assessment/models/country.dart';
import 'package:cc_assessment/repos/base_repo.dart';
import 'package:flutter/services.dart';

class CountryRepo extends BaseRepo<Country>{
  static final CountryRepo _instance = CountryRepo._internal();

  factory CountryRepo() {
    return _instance;
  }

  CountryRepo._internal() : super('countries');

  Future<void> init() async => await loadClasses();

  late List<Country> _bannedCountries;
  late List<Country> _allCountries;

  List<Country> get bannedCountries => _bannedCountries;
  List<Country> get allCountries => _allCountries;

  Country? fromName(String cName) {
    return _allCountries.firstWhereOrNull((country) => country.name == cName);
  }

  @override
  Future<bool> addClass(Country addClass) async {
    if (!_bannedCountries.contains(addClass)) {
      _bannedCountries.add(addClass);
      return await super.writeJson(
        _bannedCountries.map((Country country) => country.toJson()).toList(),
      );
    } else {
      return false;
    }
  }

  @override
  Future<void> deleteClass(Country removeClass) async {
    _bannedCountries.removeWhere((country) => country == removeClass);
    await super.writeJson(_bannedCountries.map((Country country) => country.toJson()).toList());
  }

  @override
  Future<void> loadClasses() async {
    List<dynamic> bannedCountryData = await super.readData();
    List<dynamic> allCountriesData =  jsonDecode(await rootBundle.loadString('assets/world.json')) as List<dynamic>;
    _bannedCountries = bannedCountryData.map((json) => Country.fromJson(json)).toList();
    _allCountries = allCountriesData.map((json) => Country.fromJson(json)).toList();
  }
}