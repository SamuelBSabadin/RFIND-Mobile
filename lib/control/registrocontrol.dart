import 'package:rfind_mobile/model/dao/registroDAO.dart';
import 'package:rfind_mobile/model/empresa.dart';
import 'package:rfind_mobile/model/registro.dart';

class Registrocontrol {
  Registrodao registrodao = Registrodao();
  Future<List<dynamic>> listar() async {
    return await registrodao.listar();
  }

  Future<void> excluir(int id) async {
    await registrodao.excluir(id);
  }

  Future<List<dynamic>> filtraPorEmpresaLogada() async {
    List<dynamic> lista = [];
    for (Registro registro in await listar()) {
      if (registro.empresa.cnpj == Empresa.getCnpjProvisorio) {
        lista.add(registro);
      }
    }
    return lista;
  }
}
