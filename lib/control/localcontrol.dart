import 'package:rfind_mobile/model/dao/localDAO.dart';
import 'package:rfind_mobile/model/empresa.dart';
import 'package:rfind_mobile/model/local.dart';

class Localcontrol {
  List<dynamic> _lista = [];

  Future<void> carregar() async {
    _lista = await filtraPorEmpresaLogada();
  }

  Localdao localdao = Localdao();

  Future<List<dynamic>> listar() async {
    return localdao.listar();
  }

  Future<void> excluir(int id) async {
    localdao.excluir(id);
  }

  Future<void> cadastrar(Local local) async {
    localdao.cadastrar(local);
  }

  Future<void> atualizar(Local local) async {
    localdao.atualizar(local);
  }

  Future<List<dynamic>> filtraPorEmpresaLogada() async {
    List<dynamic> lista = [];
    for (Local local in await listar()) {
      if (local.empresa.cnpj == Empresa.getCnpjProvisorio) {
        lista.add(local);
      }
    }
    return lista;
  }
}
