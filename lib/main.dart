import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:holo_products_app/features/products/presentation/bloc/products_bloc.dart';
import 'package:holo_products_app/features/products/presentation/pages/products_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holo_products_app/features/theme/domain/entity/theme_entity.dart';
import 'package:holo_products_app/features/theme/presntation/bloc/theme_bloc.dart';
import 'package:holo_products_app/l10n/app_localizations.dart';
import 'package:holo_products_app/l10n/l10n.dart';
import 'package:holo_products_app/theme/theme.dart';

import 'injection_container.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  Locale get currentLocale => _locale ?? const Locale('en'); // default to English
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ProductsBloc>()..add(GetProducts())),
        BlocProvider(create: (_) => sl<ThemeBloc>()..add(GetTheme())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
  builder: (context, state) {
    return MaterialApp(
        supportedLocales: L10n.all,
        localizationsDelegates:  const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],

        locale: _locale,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getTheme(state.themeEntity?.themeType== ThemeType.dark),
        // darkTheme: darkMode,
        home: const ProductsScreen(appName: "Holo",),
      );
  },
),
    );
  }
}


