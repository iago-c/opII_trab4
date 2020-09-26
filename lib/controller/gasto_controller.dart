import 'package:trab4_opii_iagocosta/model/gasto.dart';
import 'package:trab4_opii_iagocosta/persistence/gasto_mensal_dao.dart';

class GastoController {
  GastoMensal _ultimoRemovido;

  Future<String> salvar(GastoMensal gastoMensal) async {
    int res = 0;
    if (gastoMensal.id == null) {
      res = await GastoMensalDao.inserir(gastoMensal);
    } else {
      res = await GastoMensalDao.alterar(gastoMensal);
    }
    if (res == 0) {
      return "Erro ao salvar registro";
    } else {
      return "Salvo com sucesso.";
    }
  }

  Future<List<GastoMensal>> findAll() async {
    List<GastoMensal> gastos = await GastoMensalDao.findAll();
    return gastos;
  }

  Future<String> excluir(int id) async {
    int res = 0;
    res = await GastoMensalDao.excluir(id);
    if (res == 0) {
      return "Erro ao excluir registro";
    } else {
      return "Excluído com sucesso.";
    }
  }
}