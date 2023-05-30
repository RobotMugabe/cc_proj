import 'package:cc_assessment/models/base_class.dart';

class Country extends BaseClass {
  final String name;
  final String? code;
  const Country(this.name, {this.code});

  Country.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        code = json['code'];

  Map<String, dynamic> toJson() => {
        'cardname_number': name,
        'code': code,
      };

  @override
  List<Object?> get props => [
        name,
        code,
      ];
}
