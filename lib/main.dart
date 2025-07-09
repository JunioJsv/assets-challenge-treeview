import 'package:assets_challenge/i18n/translations.g.dart';
import 'package:assets_challenge/routes.dart';
import 'package:assets_challenge/ui/companies_assets/screens/companies_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  runApp(TranslationProvider(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      onGenerateRoute: onGenerateRoute,
      initialRoute: CompaniesScreen.route,
    );
  }
}

