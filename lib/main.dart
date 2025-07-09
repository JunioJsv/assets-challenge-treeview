import 'package:assets_challenge/dependencies.dart';
import 'package:assets_challenge/i18n/translations.g.dart';
import 'package:assets_challenge/routes.dart';
import 'package:assets_challenge/ui/companies_assets/screens/companies_screen.dart';
import 'package:assets_challenge/ui/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  runApp(TranslationProvider(child: App()));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    dependencies.initialize();
  }

  @override
  void dispose() {
    dependencies.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      onGenerateRoute: onGenerateRoute,
      themeMode: ThemeMode.light,
      theme: appTheme(),
      initialRoute: CompaniesScreen.route,
    );
  }
}
