import 'package:flutter/material.dart';
import 'package:trab4_opii_iagocosta/component/cria_dropdown.dart';
import 'package:trab4_opii_iagocosta/component/cria_textfield.dart';
import 'package:trab4_opii_iagocosta/controller/gasto_controller.dart';
import 'package:trab4_opii_iagocosta/model/gasto.dart';

import 'lista_gasto_mensal.dart';

class Cadastro extends StatefulWidget {
  final GastoMensal gasto;

  Cadastro({this.gasto});

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  var _tipoGasto = ["Fixo", "Variável", "Eventual", "Emergencial"];
  var _tipoGastoSelecionado = 'Fixo';

  var _mes = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro"
  ];
  var _mesSelecionado = 'Janeiro';

  TextEditingController _anoController = TextEditingController();
  TextEditingController _mesController = TextEditingController();
  TextEditingController _finalidadeController = TextEditingController();
  TextEditingController _valorController = TextEditingController();
  TextEditingController _tipoGastoController = TextEditingController();

  _alterarTipoGasto(String novoTipoGastoSelecionado) {
    _dropDownTipoGastoSelected(novoTipoGastoSelecionado);
    setState(() {
      this._tipoGastoSelecionado = novoTipoGastoSelecionado;
      _tipoGastoController.text = this._tipoGastoSelecionado;
    });
  }

  _dropDownTipoGastoSelected(String novoTipoGasto) {
    setState(() {
      this._tipoGastoSelecionado = novoTipoGasto;
    });
  }

  _alterarMes(String novoMesSelecionado) {
    _dropDownMesSelected(novoMesSelecionado);
    setState(() {
      this._mesSelecionado = novoMesSelecionado;
      _mesController.text = this._mesSelecionado;
    });
  }

  _dropDownMesSelected(String novoMes) {
    setState(() {
      this._mesSelecionado = novoMes;
    });
  }

  GastoController _gastoController = GastoController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _displaySnackBar(BuildContext context, String mensagem) {
    final snackBar = SnackBar(
      content: Text(mensagem),
      backgroundColor: Colors.green[900],
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _inserir(BuildContext context) {
    int _idGasto;
    if (widget.gasto != null) _idGasto = widget.gasto.id;
    GastoMensal gastoMensal = GastoMensal(
        _idGasto,
        int.parse(_anoController.text),
        _mesSelecionado,
        _finalidadeController.text,
        double.parse(_valorController.text),
        _tipoGastoSelecionado);
    setState(() {
      _gastoController.salvar(gastoMensal).then((res) {
        setState(() {
          _displaySnackBar(context, res);
        });
      });
    });
  }

  void initState() {
    if (widget.gasto != null) {
      _dropDownTipoGastoSelected(widget.gasto.tipoGasto);
      _dropDownMesSelected(widget.gasto.mes);
      _finalidadeController.text = widget.gasto.finalidade;
      _anoController.text = widget.gasto.ano.toString();
      _valorController.text = widget.gasto.valor.toString();
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Gasto mensal \$"),
        backgroundColor: Colors.purple,
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListaGastoMensal()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: criaTextField("Ano", _anoController, TextInputType.number),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Mês:",
                    style: TextStyle(color: Colors.purple),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child:
                    criaDropDownButton(_mes, _alterarMes, _mesSelecionado),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: criaTextField(
                  "Finalidade", _finalidadeController, TextInputType.text),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: criaTextField("Valor", _valorController,
                  TextInputType.numberWithOptions(decimal: true)),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Tipo da despesa:",
                    style: TextStyle(color: Colors.purple),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: criaDropDownButton(
                        _tipoGasto, _alterarTipoGasto, _tipoGastoSelecionado),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton.icon(
                  onPressed: () {
                    _inserir(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListaGastoMensal()),
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  label: Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  textColor: Colors.white,
                  splashColor: Colors.green,
                  color: Colors.purple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}