import 'package:elki_app/modules/core/presentation/l10n/app_localizations.dart';
import 'package:elki_app/modules/core/presentation/scopes/dependencies_scope.dart';
import 'package:elki_app/modules/core/presentation/scopes/repositories_scope.dart';
import 'package:elki_app/modules/core/presentation/theme/app_theme.dart';
import 'package:elki_app/modules/rent/modules/available_houses/presentation/available_houses_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  static Future<void> initializeAndRun() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp],
    );

    runApp(const App());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elki App',
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        return AppTheme(
          child: DependenciesScope(
            child: RepositoriesScope(
              child: child!,
            ),
          ),
        );
      },
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: const AvailableHousesScreen(),
    );
  }
}
