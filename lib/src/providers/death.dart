import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';
import 'dart:math';

class Muerte {
  final String menorSalud;
  final String mayorSalud;
  final String menorDinero;
  final String mayorDinero;
  final String menorCarisma;
  final String mayorCarisma;
  final String menorSuerte;
  final String mayorSuerte;
  final String random;
  final String imageSalud;
  final String imageDinero;
  final String imageCarisma;
  final String imageSuerte;
  final String imageRandom;

  Muerte(
    this.menorSalud,
    this.mayorSalud,
    this.menorDinero,
    this.mayorDinero,
    this.menorCarisma,
    this.mayorCarisma,
    this.menorSuerte,
    this.mayorSuerte,
    this.random,
    this.imageSalud,
    this.imageDinero,
    this.imageCarisma,
    this.imageSuerte,
    this.imageRandom,
  );
}

class CargarMuerte {
  CargarMuerte() {
    cargarData();
  }

  Future<Muerte> cargarData() async {
    final resp = await rootBundle.loadString('data/death.json');
    Map dataMap = json.decode(resp);
    var random = new Random();

    Muerte muerte = new Muerte(
      dataMap['salud']['menor'][(random.nextInt(5) + 1).toString()],
      dataMap['salud']['mayor'][(random.nextInt(5) + 1).toString()],
      dataMap['dinero']['menor'][(random.nextInt(5) + 1).toString()],
      dataMap['dinero']['mayor'][(random.nextInt(5) + 1).toString()],
      dataMap['carisma']['menor'][(random.nextInt(5) + 1).toString()],
      dataMap['carisma']['mayor'][(random.nextInt(5) + 1).toString()],
      dataMap['suerte']['menor'][(random.nextInt(5) + 1).toString()],
      dataMap['suerte']['mayor'][(random.nextInt(5) + 1).toString()],
      dataMap['random'][(random.nextInt(5) + 1).toString()],
      dataMap['salud']['image'],
      dataMap['dinero']['image'],
      dataMap['carisma']['image'],
      dataMap['suerte']['image'],
      dataMap['random']['image'],
    );

    return muerte;
  }
}

final cargaMuertes = new CargarMuerte();
