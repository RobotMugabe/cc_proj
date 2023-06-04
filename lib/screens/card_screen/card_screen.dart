import 'package:cc_assessment/models/credit_card.dart';
import 'package:cc_assessment/screens/card_screen/card_screen_cubit/card_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key, required this.router});
  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardScreenCubit, CardScreenState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Credit Cards'),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BlocBuilder<CardScreenCubit, CardScreenState>(
                  bloc: BlocProvider.of<CardScreenCubit>(context),
                  builder: (context, state) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.creditCards.length,
                        itemBuilder: (context, index) => creditCard(
                          state.creditCards[index],
                          context,
                        ),
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(width: 5),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.credit_card),
                      label: const Text('Add Card'),
                      onPressed: () {
                        router.go('/card_reader');
                      },
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.disabled_by_default),
                      label: const Text('Edit Banned Countries'),
                      onPressed: () {
                        router.go('/banned_country');
                      },
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
                const SizedBox(height: 5)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget creditCard(CreditCard card, BuildContext context) {
    return SizedBox(
      height: 0.63 * MediaQuery.of(context).size.width,
      child: Card(
        elevation: 40,
        shadowColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          ),
        ),
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            children: [
              _chipAndCardType(card),
              Expanded(
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      card.friendlyCardNumber,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
              ),
              //TODO add expiry date
              /* Expanded(
                child: Container(child: Text('09/99')),
              ), */
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  constraints: const BoxConstraints.expand(),
                  child: Text(
                    '${card.accountHolder}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _chipAndCardType(CreditCard card) {
    return Expanded(
      child: Row(
        children: [
          const SizedBox(width: 7),
          Image.asset('assets/chip.png', height: 40),
          Expanded(child: Container()),
          if (card.ccType != CardType.unknown)
            Image.asset('assets/${card.ccType.name}.png', height: 40),
          const SizedBox(width: 7),
        ],
      ),
    );
  }
}
