import 'package:at_protocol_basics/services/get_it.dart';
import 'package:at_protocol_basics/services/services.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked_themes/stacked_themes.dart';

import 'app/app_router.gr.dart';
import 'app/themes/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies(); // Creates all necessary services for get_it
  await Hive.initFlutter();
  await initializeServices();
  await atProtocolService.setup();
  await ThemeManager.initialise();
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      defaultThemeMode: ThemeMode.light,
      lightTheme: lightTheme,
      darkTheme: lightTheme,
      builder: (context, regularTheme, darkTheme, themeMode) => MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: themeMode,
        darkTheme: darkTheme,
        theme: regularTheme,
        builder: ExtendedNavigator.builder(
          router: AppRouter(),
          initialRoute: Routes.startView,
          builder: (context, extendedNav) => extendedNav,
        ),
      ),
    );
  }
}
