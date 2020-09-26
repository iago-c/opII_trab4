import 'package:flutter/material.dart';
import 'package:trab4_opii_iagocosta/view/cadastro_gasto_mensal.dart';
import 'package:trab4_opii_iagocosta/view/lista_gasto_mensal.dart';

void main() {
  runApp(MaterialApp(
    home: ListaGastoMensal(),
    theme: ThemeData(
        hintColor: Colors.purple,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
          hintStyle: TextStyle(color: Colors.purple),
        )),
  ));
}