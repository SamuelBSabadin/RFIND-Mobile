import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rfind_mobile/model/empresa.dart';
import 'package:rfind_mobile/model/produto.dart';

class Produtodao {
  Future<List<dynamic>> listar() async {
    List<dynamic> listaTemp = [];
    var url = Uri.parse("http://localhost:8080/apiRfind/produto/listar");
    var resposta = await http.get(url);
    var jsonData = jsonDecode(resposta.body);
    for (var produto in jsonData) {
      Produto produtoTemp = Produto.empty();

      produtoTemp.id = produto["id"];
      produtoTemp.nome = produto["nome"] ?? "";
      produtoTemp.categoria = produto["categoria"] ?? "";
      produtoTemp.dataFabricacao = produto["dataFab"];
      produtoTemp.dataValidade = produto["dataValidade"];
      produtoTemp.descricao = produto["descricao"] ?? "";
      produtoTemp.fornecedor = produto["fornecedor"] ?? "";
      produtoTemp.preco = produto["preco"]?.toDouble() ?? 0.0;
      produtoTemp.qtdEstoque = produto["quantidadeEstoque"] ?? 0;
      produtoTemp.ativado = produto["ativado"] ?? false;

      var empresaJson = produto["empresa"];
      produtoTemp.empresa =
          empresaJson != null
              ? Empresa.fromJson(empresaJson)
              : Empresa("", "", "", "");

      listaTemp.add(produtoTemp);
    }
    return listaTemp;
  }

  Future<void> atualizar(Produto produto) async {
    String id = produto.id.toString();
    String nome = produto.nome;
    String categoria = produto.categoria;
    String dataFab = produto.dataFabricacao.toString();
    String dataVal = produto.dataValidade.toString();
    String descricao = produto.descricao;
    String fornecedor = produto.fornecedor;
    double preco = produto.preco;
    String qtdEstoque = produto.qtdEstoque.toString();
    String ativado = produto.ativado.toString();
    String empresa_id = produto.empresa.id.toString();
    var url = Uri.parse("http://localhost:8080/apiRfind/produto/atualizar");
    await http.put(
      url,
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        "id": id,
        "nome": nome,
        "categoria": categoria,
        "dataFab": dataFab,
        "dataValidade": dataVal,
        "descricao": descricao,
        "fornecedor": fornecedor,
        "preco": preco,
        "quantidadeEstoque": qtdEstoque,
        "ativado": ativado,
        "empresa": {"id": empresa_id},
      }),
    );
  }

  Future<void> cadastrar(Produto produto) async {
    String nome = produto.nome;
    String categoria = produto.categoria;
    String dataFab = produto.dataFabricacao;
    String dataVal = produto.dataValidade;
    String descricao = produto.descricao;
    String fornecedor = produto.fornecedor;
    String preco = produto.preco.toString();
    String qtdEstoque = produto.qtdEstoque.toString();
    String ativado = produto.ativado.toString();
    String empresa_id = produto.empresa.id.toString();
    var url = Uri.parse("http://localhost:8080/apiRfind/produto/cadastrar");
    await http.post(
      url,
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        "nome": nome,
        "categoria": categoria,
        "dataFab": dataFab,
        "dataValidade": dataVal,
        "descricao": descricao,
        "fornecedor": fornecedor,
        "preco": preco,
        "quantidadeEstoque": qtdEstoque,
        "ativado": ativado,
        "empresa": {"id": empresa_id},
      }),
    );
  }

  Future<void> excluir(int id) async {
    var url = Uri.parse("http://localhost:8080/apiRfind/produto/excluir/$id");
    await http.delete(url);
  }
}
