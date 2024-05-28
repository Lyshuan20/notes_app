import 'package:flutter/material.dart';

//--- Modo claro
ThemeData modoClaro = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade200,
    primary: Colors.grey.shade50,
    secondary: Colors.grey.shade300,
    inversePrimary: Colors.grey.shade800,
    // - Colores Categoria
  ),
);

//--- Modo Oscuro
ThemeData modoOscuro = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade300,
  ),
);