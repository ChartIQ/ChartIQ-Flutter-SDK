import 'package:example/app_preferences.dart';
import 'package:example/gen/localization/app_localizations.gen.dart';
import 'package:example/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/locale_provider.dart';
import 'routes/routers.dart';
import 'routes/screen_names.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocaleProvider>(
      create: (_) => LocaleProvider(AppPreferences.getLanguage()),
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: AppTheme().theme,
            darkTheme: AppTheme().darkTheme,
            initialRoute: ScreenNames.splash,
            onGenerateRoute: (RouteSettings setting) =>
                Routes.generateRoute(setting),
            builder: (context, child) {
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarBrightness: Theme.of(context).brightness,
                ),
                child: child!,
              );
            },
            localizationsDelegates: L.localizationsDelegates,
            supportedLocales: L.supportedLocales,
            locale: localeProvider.appLanguage.locale,
          );
        },
      ),
    );
  }
}
