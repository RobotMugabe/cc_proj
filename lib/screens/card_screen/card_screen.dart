import 'package:cc_assessment/screens/card_screen/card_screen_cubit/card_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardScreenCubit, CardScreenState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Credit Cards'),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Credit Cards'),
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).go('/add_card');
                  },
                  child: const Text('Add Credit Card'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
