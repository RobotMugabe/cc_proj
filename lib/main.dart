import 'dart:convert';

import 'package:cc_assessment/screens/add_card_screen/add_card_screen_cubit/add_card_screen_cubit.dart';
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
  runApp(CreditCardApp(theme));
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return CardScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'add_card',
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(
              create: (context) => AddCardScreenCubit(),
              child: Container(),
            ); //const AddCardScreen();
          },
        ),
      ],
    ),
  ],
);

class CreditCardApp extends StatelessWidget {
  final ThemeData? theme;

  const CreditCardApp(this.theme, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardScreenCubit()..loadCards(),
      child: MaterialApp.router(
        //debugShowCheckedModeBanner: false,
        theme: theme,
        routerConfig: _router,
      ),
    );
  }
}
