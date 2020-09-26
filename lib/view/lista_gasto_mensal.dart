import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trab4_opii_iagocosta/controller/gasto_controller.dart';
import 'package:trab4_opii_iagocosta/model/gasto.dart';

import 'cadastro_gasto_mensal.dart';
import 'gasto_item.dart';

class ListaGastoMensal extends StatefulWidget {
  @override
  _ListaGastoMensalState createState() => _ListaGastoMensalState();
}

class _ListaGastoMensalState extends State<ListaGastoMensal> {
  GastoController _gastoController = GastoController();

  GastoMensal _ultimoRemovido;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Gasto mensal \$"),
        backgroundColor: Colors.purple,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<GastoMensal>>(
        initialData: List(),
        future: _gastoController.findAll(),
        // ignore: missing_return
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Carregando..."),
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<GastoMensal> gastos = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final GastoMensal gastoMensal = gastos[index];
                  return GastoItem(
                    gastoMensal: gastoMensal,
                    onRemoved: () {
                      setState(
                            () {
                          _gastoController.excluir(gastoMensal.id);
                          _ultimoRemovido = gastoMensal;
                          _ultimoRemovido.id = null;

                          final snack = SnackBar(
                            content: Text(
                              //${_ultimoRemovido["descricaoObjeto"]}\
                              "Gasto mensal \"${_ultimoRemovido.getGastoMensal()["finalidade"]}\" removido!",
                              style: TextStyle(color: Colors.black),
                            ),
                            backgroundColor: Colors.purpleAccent,
                            action: SnackBarAction(
                                label: "Desfazer",
                                onPressed: () {
                                  setState(() {
                                    _gastoController.salvar(_ultimoRemovido);
                                  });
                                }),
                            duration: Duration(seconds: 2),
                          );

                          Scaffold.of(context).removeCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(snack);
                        },
                      );
                    },
                  );
                },
                itemCount: gastos.length,
              );
              break;
          }
          return Text("Erro");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Cadastro(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purpleAccent,
      ),
    );
  }
}