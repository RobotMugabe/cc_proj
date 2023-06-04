import 'package:cc_assessment/models/base_class.dart';

class Country extends BaseClass {
  final String name;
  final String alpha2;
  final String alpha3;
  const Country(
    this.name, {
    required this.alpha2,
    required this.alpha3,
  });

  Country.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        alpha2 = json['alpha2'],
        alpha3 = json['alpha3'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'alpha2': alpha2,
        'alpha3': alpha3,
      };

  @override
  List<Object?> get props => [
        name,
        alpha2,
        alpha3,
      ];
}