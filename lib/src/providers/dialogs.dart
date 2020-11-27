import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';

class Dialogo {
  final String personaje;
  final String imagen;
  final String dialogo;
  final bool aleatorio;
  final String izquierdaDialogo;
  final double izquierdaSalud;
  final double izquierdaDinero;
  final double izquierdaReputacion;
  final double izquierdaSantidad;
  final String derechaDialogo;
  final double derechaSalud;
  final double derechaDinero;
  final double derechaReputacion;
  final double derechaSantidad;

  Dialogo(
      this.personaje,
      this.imagen,
      this.dialogo,
      this.aleatorio,
      this.izquierdaDialogo,
      this.izquierdaSalud,
      this.izquierdaDinero,
      this.izquierdaReputacion,
      this.izquierdaSantidad,
      this.derechaDialogo,
      this.derechaSalud,
      this.derechaDinero,
      this.derechaReputacion,
      this.derechaSantidad);
}

class _CargaDialogos {
  _CargaDialogos() {
    cargarData();
  }

  Future<List<Dialogo>> cargarData() async {
    List<Dialogo> dialogos = new List();

    final resp = await rootBundle.loadString('data/example.json');

    Map dataMap = json.decode(resp);

    dataMap['historia'].forEach((key, value) {
      dialogos.add(new Dialogo(
          dataMap['historia'][key]['personaje'],
          dataMap['historia'][key]['imagen'],
          dataMap['historia'][key]['dialogo'],
          dataMap['historia'][key]['aleatorio'] == 'true',
          dataMap['historia'][key]['izquierda']['dialogo'],
          double.parse(dataMap['historia'][key]['izquierda']['salud']),
          double.parse(dataMap['historia'][key]['izquierda']['dinero']),
          double.parse(dataMap['historia'][key]['izquierda']['reputacion']),
          double.parse(dataMap['historia'][key]['izquierda']['santidad']),
          dataMap['historia'][key]['derecha']['dialogo'],
          double.parse(dataMap['historia'][key]['derecha']['salud']),
          double.parse(dataMap['historia'][key]['derecha']['dinero']),
          double.parse(dataMap['historia'][key]['derecha']['reputacion']),
          double.parse(dataMap['historia'][key]['derecha']['santidad'])));
    });

    return dialogos;
  }
}

final cargaDialogos = new _CargaDialogos();
