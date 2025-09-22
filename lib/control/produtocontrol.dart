import 'package:rfind_mobile/model/dao/produtoDAO.dart';
import 'package:rfind_mobile/model/empresa.dart';
import 'package:rfind_mobile/model/produto.dart';

class Produtocontrol {
  List<dynamic> _lista = [];
  Produtodao produtodao = Produtodao();

  get Lista => this._lista;

  Future<void> carregarAtivados() async {
    _lista = await filtraPorEmpresaLogadaAtivados();
  }

  Future<void> carregarDesativados() async {
    _lista = await filtraPorEmpresaLogadaDesativados();
  }

  Future<List<dynamic>> listar() async {
    return await produtodao.listar();
  }

  Future<void> excluir(int id) async {
    await produtodao.excluir(id);
  }

  Future<void> cadastrar(Produto produto) async {
    await produtodao.cadastrar(produto);
  }

  Future<void> atualizar(Produto produto) async {
    await produtodao.atualizar(produto);
  }

  Future<List<dynamic>> filtraPorEmpresaLogadaAtivados() async {
    List<dynamic> lista = [];
    for (var produto in await listar()) {
      if (produto.empresa.cnpj == Empresa.getCnpjProvisorio &&
          produto.ativado == true) {
        lista.add(produto);
      }
    }
    return lista;
  }

  Future<List<dynamic>> filtraPorEmpresaLogadaDesativados() async {
    List<dynamic> lista = [];
    for (var produto in await listar()) {
      if (produto.empresa.cnpj == Empresa.getCnpjProvisorio &&
          produto.ativado == false) {
        lista.add(produto);
      }
    }
    return lista;
  }

  Future<void> desativar(int id) async {
    bool produtoExiste = false;
    Produto produto = Produto.empty();
    for (Produto p in await filtraPorEmpresaLogadaAtivados()) {
      if (p.id == id) {
        produtoExiste = true;
        produto = p;
        break;
      }
    }
    if (produtoExiste) {
      produto.ativado = false;
      await atualizar(produto);
    }
  }

  Future<void> reativar(int id) async {
    bool produtoExiste = false;
    Produto produto = Produto.empty();
    for (Produto p in await filtraPorEmpresaLogadaDesativados()) {
      if (p.id == id) {
        produtoExiste = true;
        produto = p;
        break;
      }
    }
    if (produtoExiste) {
      produto.ativado = true;
      await atualizar(produto);
    }
  }
}
