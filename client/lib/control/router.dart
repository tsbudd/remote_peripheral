import 'package:client/view/pages/home/home_page.dart';
import 'package:client/view/pages/unknown_page.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:yaru/yaru.dart' as yaru;
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrouter/vrouter.dart';


class CustRouter extends ConsumerWidget {

  final AdaptiveThemeMode? savedThemeMode;

  const CustRouter({Key? key, this.savedThemeMode}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Before we build anything, get or create our user
    //ref.watch(ScadaUserProvider.notifier);

    return AdaptiveTheme(
      light: yaru.yaruBlueLight,
      dark: yaru.yaruBlueDark,
      initial: savedThemeMode ?? AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) =>  VRouter(
        debugShowCheckedModeBanner: false,
        initialUrl: "/",
        title: 'Peripheral Remote',
        theme: theme,
        darkTheme: darkTheme,
        localizationsDelegates: const [
          // AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
          Locale('es', ''), // Spanish, no country code
          Locale('de', ''), // German, no country code
          Locale('nl', ''), // Dutch, no country code
          Locale('zh', ''), // Chinese, no country code
        ],
        routes: [
          VWidget(
            path: "/",
            name: "home",
            widget: FindBlePage(),
          ),
          VWidget(
            path: "/ble_control/",
            name: "bluetoothControl",
            widget: UnknownPage(key: UniqueKey()),
          ),
          VWidget(
              path: "/unknown",
              name: "unknown",
              widget: UnknownPage(key: UniqueKey())
          ),
          VRouteRedirector(
              path: '*',
              redirectTo: '/unknown'
          ),
        ],
      ),
    );
  }
}