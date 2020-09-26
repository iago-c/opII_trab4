import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trab4_opii_iagocosta/model/gasto.dart';

import 'cadastro_gasto_mensal.dart';

class GastoItem extends StatelessWidget {
  final GastoMensal gastoMensal;
  final VoidCallback onRemoved;

  GastoItem({@required this.gastoMensal, this.onRemoved});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: Card(
        color: Colors.purpleAccent,
        child: ListTile(
          title: Text(
            gastoMensal.finalidade,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          subtitle: Text(
            gastoMensal.valor.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Cadastro(
                  gasto: gastoMensal,
                ),
              ),
            );
          },
        ),
      ),
      onDismissed: (direction) {
        onRemoved();
      },
    );
  }
}