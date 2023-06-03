import 'dart:convert';

import 'package:cc_assessment/repos/country_repo.dart';
import 'package:cc_assessment/repos/credit_card_repo.dart';
import 'package:cc_assessment/screens/add_card_screen/add_card_screen.dart';
import 'package:cc_assessment/screens/card_screen/card_screen.dart';
import 'package:cc_assessment/screens/card_screen/card_screen_cubit/card_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:json_theme/json_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/cc_proj_theme.json');
  final themeJson = jsonDecode(themeStr);
  final ThemeData? theme = ThemeDecoder.decodeThemeData(themeJson, validate: false);
  final CreditCardRepo cardRepo = CreditCardRepo();
  final CountryRepo countryRepo = CountryRepo();
  await cardRepo.init();
  await countryRepo.init();
  runApp(CreditCardApp(theme, cardRepo, countryRepo));
}

final GoRouter router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            BlocProvider.of<CardScreenCubit>(context).loadCards();
            return CardScreen();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'add_card',
              builder: (BuildContext context, GoRouterState state) {
                return AddCardScreen(router: router);
              },
            ),
          ],
        ),
      ],
    );

class CreditCardApp extends StatelessWidget {
  final ThemeData? theme;
  final CreditCardRepo cardRepo;
  final CountryRepo countryRepo;

  const CreditCardApp(
    this.theme,
    this.cardRepo,
    this.countryRepo, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardScreenCubit(),
      child: MaterialApp.router(
        //debugShowCheckedModeBanner: false,
        theme: theme,
        routerConfig: router,
      ),
    );
  }
}
