//Libraries
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Extensions
import 'package:flutter_localizations/flutter_localizations.dart';

//Routes
import 'package:ockams_razor/src/routes/routes.dart';

//Pages
import 'package:ockams_razor/src/pages/error.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: "Ockam's Razor",
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('es', 'ES'),
      ],
      initialRoute: 'animation',
      routes: getAplicationRoutes(),
      onGenerateRoute: (RouteSettings settings) {
        print('Ruta a la que intentó acceder: ${settings.name}');
        return MaterialPageRoute(
            builder: (BuildContext context) => ErrorPage());
      },
      theme: ThemeData(fontFamily: 'Goldman'),
    );
  }
}
