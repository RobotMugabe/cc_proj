import 'package:cc_assessment/models/country.dart';
import 'package:cc_assessment/repos/country_repo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BanCountryScreen extends StatefulWidget {
  final GoRouter router;
  const BanCountryScreen({
    super.key,
    required this.router,
  });

  @override
  State<BanCountryScreen> createState() => _BanCountryScreenState();
}

class _BanCountryScreenState extends State<BanCountryScreen> {

  late List<Country> countries;
  late List<Country> filtered;

  @override
  void initState() {
    super.initState();
    countries = CountryRepo().allCountries;
    filtered = CountryRepo().allCountries;
  }

  _saveOrRemove(Country country) async {
    if (CountryRepo().bannedCountries.contains(country)) {
      await CountryRepo().deleteClass(country);
    } else {
      CountryRepo().addClass(country);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Country To Ban or Unban'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(5),
                child: TextField(
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      filtered = countries
                          .where(
                              (country) => country.name.toLowerCase().contains(value.toLowerCase()))
                          .toList();
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: 'Filter list',
                      //hintText: 'Filter list',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                            width: 2,
                            style: BorderStyle.solid),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 4,
                            style: BorderStyle.solid),
                      ),
                    )),
              ),
            ),
            Expanded(
              flex: 8,
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 60,
                    child: GestureDetector(
                      onTap: () async {
                        await _saveOrRemove(filtered[index]);
                      },
                      child: Card(
                        color: CountryRepo().bannedCountries.contains(filtered[index])
                            ? Theme.of(context).colorScheme.error
                            : null,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Text(filtered[index].name),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
