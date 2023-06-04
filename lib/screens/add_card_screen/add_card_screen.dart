import 'package:cc_assessment/extensions.dart';
import 'package:cc_assessment/models/country.dart';
import 'package:cc_assessment/models/credit_card.dart';
import 'package:cc_assessment/repos/country_repo.dart';
import 'package:cc_assessment/repos/credit_card_repo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:searchfield/searchfield.dart';

int doubleAndSumDigits(int digit) {
  //Double digit, if this is greater than 9 then subtract 9
  return ((digit * 2) > 9) ? ((digit * 2) - 9) : (digit * 2);
}

bool luhnAlgorithm(String value) {
  int sum = 0;
  for (int i = value.length - 1; i >= 0; i--) {
    int digit = int.parse(value.substring(i, i + 1));
    if ((value.length - i) % 2 == 0) {
      digit = doubleAndSumDigits(digit);
    }
    sum += digit;
  }
  return sum % 10 == 0;
}

class AddCardScreen extends StatefulWidget {
  final GoRouter router;
  final Map<String, dynamic>? scanData;
  final void Function(String message) messageFunction;
  const AddCardScreen({
    super.key,
    required this.router,
    this.scanData,
    required this.messageFunction,
  });

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _key = GlobalKey<FormState>();
  late final FocusNode _countryNode;
  late final FocusNode _cvvNode;
  late final TextEditingController _cardNumberController;
  late final TextEditingController _cvvController;
  late final TextEditingController _nameController;
  Country? _country;
  CardType? _cardType;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _countryNode = FocusNode();
    _cvvNode = FocusNode();
    _cardType =
        widget.scanData != null ? getCardTypeFromCardNumber(widget.scanData!['card_number']) : null;
    _cardNumberController = TextEditingController(
        text: widget.scanData != null ? widget.scanData!['card_number'] : null);
    _cvvController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fill In Credit Card Details'),
      ),
      body: Form(
        key: _key,
        child: Container(
          constraints: const BoxConstraints.expand(),
          margin: const EdgeInsets.all(10),
          child: _isSaving
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Wrap(
                  runSpacing: 20,
                  children: <Widget>[
                    _cardNumberField(context),
                    _cardTypeDropdown(context),
                    _cvvField(context),
                    _nameField(context),
                    _countryDropdown(context),
                    ElevatedButton(onPressed: _submit, child: const Text('Submit'))
                  ],
                ),
        ),
      ),
    );
  }

  void _submit() async {
    setState(() {
      _isSaving = true;
    });
    _countryNode.unfocus();
    if (_key.currentState!.validate()) {
      await _saveCard();
    } else {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Future<void> _saveCard() async {
    final CreditCard card = CreditCard(
      cardNumber: int.parse(_cardNumberController.text),
      ccType: _cardType!,
      cvv: int.parse(_cvvController.text),
      country: _country!.name,
      accountHolder: _nameController.text,
    );
    final success = await CreditCardRepo().addClass(card);
    if (success) {
      widget.router.pop();
    } else {
      setState(() {
        _isSaving = false;
      });
      widget.messageFunction('Card already saved');
    }
  }

  InputDecoration _decoration(String label, BuildContext context, {String? hint}) =>
      InputDecoration(
        labelText: label,
        hintText: hint,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error, width: 4, style: BorderStyle.solid),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline, width: 2, style: BorderStyle.solid),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 4, style: BorderStyle.solid),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error, width: 2, style: BorderStyle.solid),
        ),
      );

  String? cardNumberValidator(String? value) {
    if (value == null) {
      return 'Fill in card number';
    } else if (int.tryParse(value) == null) {
      return 'Not an integer';
    } else if (value.length <= 12) {
      return 'Number should be 12 digits or more';
    } else if (luhnAlgorithm(value) == true) {
      return null;
    }
    return 'failed Luhn algorithm validity test';
  }

  String? cvvValidator(String? value) {
    if (value == null) {
      return 'Fill in cvv';
    } else if (int.tryParse(value) == null) {
      return 'Not an integer';
    } else if (value.length < 3) {
      return 'Number should be 3 digits or more';
    }
    return null;
  }

  String? _cardTypeValidator(CardType? value) {
    if (value == null) {
      return 'Select card type';
    }

    return null;
  }

  String? _countryValidator(String? value) {
    if (value == null) {
      return 'Select country of origin';
    } else if (CountryRepo().bannedCountries.contains(_country)) {
      return 'Banned country';
    } else if (CountryRepo().fromName(value) == null) {
      return 'Please select a country from the list';
    }
    return null;
  }

  String? _nameValidator(String? value) {
    if (value == null) {
      return 'Fill in name on card';
    }
    return null;
  }

  Widget _cardNumberField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _cardNumberController,
      validator: (value) => cardNumberValidator(value),
      decoration: _decoration('Card Number', context),
      onFieldSubmitted: (value) {
        _key.currentState!.validate();
        _cardType = getCardTypeFromCardNumber(value);
        _cvvNode.nextFocus();
        setState(() {});
      },
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.always,
    );
  }

  Widget _cardTypeDropdown(BuildContext context) {
    return DropdownButtonFormField(
      value: _cardType,
      decoration: _decoration('Card Type', context),
      isExpanded: true,
      validator: _cardTypeValidator,
      autovalidateMode: AutovalidateMode.always,
      items: CardType.values
          //.where((cardType) => cardType != CardType.unknown)
          .map(
            (CardType country) => DropdownMenuItem<CardType>(
              value: country,
              child: Text(country.name.titleCase()),
            ),
          )
          .toList(),
      onChanged: (cardType) => _cardType = cardType,
    );
  }

  Widget _cvvField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _cvvController,
      validator: (value) => cvvValidator(value),
      focusNode: _cvvNode,
      decoration: _decoration('CVV Number', context),
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _nameField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: _nameController,
      validator: (value) => _nameValidator(value),
      decoration: _decoration('Name on Card', context),
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _countryDropdown(BuildContext context) {
    return SearchField(
      initialValue: null,
      searchInputDecoration:
          _decoration('Issuing Country', context, hint: 'Search for Country or Territory'),
      validator: _countryValidator,
      focusNode: _countryNode,
      inputType: TextInputType.name,
      suggestions: CountryRepo()
          .allCountries
          .map(
            (Country country) => SearchFieldListItem<Country>(
              country.name,
              item: country,
              child: Text(country.name),
            ),
          )
          .toList(),
      onSuggestionTap: (country) {
        _country = country.item;
        _countryNode.unfocus();
      },
    );
  }
}
