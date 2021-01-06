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
    SystemChrome.setEnabledSystemUIOverlays(
        []); //Activar modo pantalla completa
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]); //Limitar el funcionamiento de la app a pantalla vertical
    return MaterialApp(
      title: "Ockam's Razor",
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        //Función utilizada para usar archivos de otras carpetas
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        //Definición de lengiajes de la aplicación
        const Locale('en', 'US'),
        const Locale('es', 'ES'),
      ],
      initialRoute: 'animation',
      routes:
          getAplicationRoutes(), //Creación de rutas de la aplicación, ver más en src/routes
      onGenerateRoute: (RouteSettings settings) {
        //Capturación de ingresos a rutas no definidas
        print('Ruta a la que intentó acceder: ${settings.name}');
        return MaterialPageRoute(
            builder: (BuildContext context) => ErrorPage());
      },
      //Cambio de fuente de texto por defecto de la aplicación
      theme: ThemeData(fontFamily: 'Goldman'),
    );
  }
}
