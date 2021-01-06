import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';

//Clase orientada a guardar la información del Json relacionado a los dialogos de la apliación
class Dialogo {
  final String key;
  final String personaje;
  final String imagen;
  final String dialogo;
  final bool aleatorio;
  final String izquierdaDialogo;
  final double izquierdaSalud;
  final double izquierdaDinero;
  final double izquierdaCarisma;
  final double izquierdaSuerte;
  final String derechaDialogo;
  final double derechaSalud;
  final double derechaDinero;
  final double derechaCarisma;
  final double derechaSuerte;

  Dialogo(
      this.key,
      this.personaje,
      this.imagen,
      this.dialogo,
      this.aleatorio,
      this.izquierdaDialogo,
      this.izquierdaSalud,
      this.izquierdaDinero,
      this.izquierdaCarisma,
      this.izquierdaSuerte,
      this.derechaDialogo,
      this.derechaSalud,
      this.derechaDinero,
      this.derechaCarisma,
      this.derechaSuerte);
}

//Método encargado de leer el archivo Json y estructurarlos
class CargaDialogos {
  CargaDialogos(String section, String keySection) {
    cargarData(section, keySection);
  }

  Future<List<Dialogo>> cargarData(String section, String keySection) async {
    List<Dialogo> dialogos = new List();

    final resp = await rootBundle.loadString('data/historiav1.json');

    Map dataMap = json.decode(resp);

    dataMap[section].forEach((key, value) {
      if (keySection == key) {
        dialogos = new List();
      }
      dialogos.add(new Dialogo(
          key,
          dataMap[section][key]['personaje'],
          dataMap[section][key]['imagen'],
          dataMap[section][key]['dialogo'],
          dataMap[section][key]['aleatorio'] == 'true',
          dataMap[section][key]['izquierda']['dialogo'],
          double.parse(dataMap[section][key]['izquierda']['salud']),
          double.parse(dataMap[section][key]['izquierda']['dinero']),
          double.parse(dataMap[section][key]['izquierda']['carisma']),
          double.parse(dataMap[section][key]['izquierda']['suerte']),
          dataMap[section][key]['derecha']['dialogo'],
          double.parse(dataMap[section][key]['derecha']['salud']),
          double.parse(dataMap[section][key]['derecha']['dinero']),
          double.parse(dataMap[section][key]['derecha']['carisma']),
          double.parse(dataMap[section][key]['derecha']['suerte'])));
    });

    return dialogos;
  }
}

//Variables utilizadas para simular la carga o imagen base de la transición de los dialogos
final dialogoCarga = new Dialogo(
    "99", '1', 'assets/poof.gif', '', true, '', 0, 0, 0, 0, "", 0, 0, 0, 0);
final dialogoFondo = new Dialogo(
    "99", '1', 'assets/fondo.jpg', '', true, '', 0, 0, 0, 0, "", 0, 0, 0, 0);
