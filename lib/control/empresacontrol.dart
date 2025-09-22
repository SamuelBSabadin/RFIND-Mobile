import 'package:rfind_mobile/model/dao/empresaDAO.dart';
import 'package:rfind_mobile/model/empresa.dart';

Empresadao empresadao = Empresadao();

class Empresacontrol {
  Future<void> cadastrar(Empresa empresa) async {
    await empresadao.cadastrar(empresa);
  }

  Future<List<dynamic>> select() async {
    return await empresadao.listar();
  }

  Future<void> atualizar(Empresa empresa) async {
    await empresadao.atualizar(empresa);
  }

  Future<void> excluir(int id) async {
    await empresadao.excluir(id);
  }
}
