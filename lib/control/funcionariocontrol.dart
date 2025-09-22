import 'package:rfind_mobile/model/dao/funcionarioDAO.dart';
import 'package:rfind_mobile/model/empresa.dart';
import 'package:rfind_mobile/model/funcionario.dart';

class Funcionariocontrol {
  List<dynamic> _lista = [];

  get lista => this._lista;

  Future<void> carregarAtivados() async {
    _lista = await filtraPorEmpresaLogadaAtivados();
  }

  Future<void> carregarDesativados() async {
    _lista = await filtraPorEmpresaLogadaDesativados();
  }

  Funcionariodao funcionariodao = Funcionariodao();

  Future<void> cadastrar(Funcionario funcionario) async {
    await funcionariodao.cadastrar(funcionario);
  }

  Future<void> atualizar(Funcionario funcionario) async {
    await funcionariodao.atualizar(funcionario);
  }

  Future<List<dynamic>> listar() async {
    return await funcionariodao.listar();
  }

  Future<void> excluir(int id) async {
    await funcionariodao.excluir(id);
  }

  Future<List<dynamic>> filtraPorEmpresaLogadaAtivados() async {
    List<dynamic> lista = [];
    for (var funcionario in await listar()) {
      if (funcionario.empresa.cnpj == Empresa.getCnpjProvisorio &&
          funcionario.ativado == true) {
        lista.add(funcionario);
      }
    }
    return lista;
  }

  Future<List<dynamic>> filtraPorEmpresaLogadaDesativados() async {
    List<dynamic> lista = [];
    for (var funcionario in await listar()) {
      if (funcionario.empresa.cnpj == Empresa.getCnpjProvisorio &&
          funcionario.ativado == false) {
        lista.add(funcionario);
      }
    }
    return lista;
  }

  Future<void> desativar(int id) async {
    bool funcionarioExiste = false;
    Funcionario funcionario = Funcionario.empty();
    for (Funcionario f in await filtraPorEmpresaLogadaAtivados()) {
      if (f.id == id) {
        funcionario = f;
        funcionarioExiste = true;
        break;
      }
    }
    if (funcionarioExiste) {
      funcionario.ativado = false;
      await atualizar(funcionario);
    }
  }

  Future<void> reativar(int id) async {
    bool funcionarioExiste = false;
    Funcionario funcionario = Funcionario.empty();
    for (Funcionario f in await filtraPorEmpresaLogadaDesativados()) {
      if (f.id == id) {
        funcionario = f;
        funcionarioExiste = true;
        break;
      }
    }
    if (funcionarioExiste) {
      funcionario.ativado = true;
      await atualizar(funcionario);
    }
  }
}
