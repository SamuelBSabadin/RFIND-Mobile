import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rfind_mobile/model/empresa.dart';

class Empresadao {
  Future<List<dynamic>> listar() async {
    var url = Uri.parse("http://localhost:8080/apiRfind/empresa/listar");
    var resposta = await http.get(url);

    if (resposta.statusCode == 200) {
      final List<dynamic> listaTemp = json.decode(resposta.body);
      return listaTemp.map((json) => Empresa.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }

  Future<void> cadastrar(Empresa empresa) async {
    String cnpj = empresa.cnpj;
    String email = empresa.email;
    String nome = empresa.nome;
    String senha = empresa.senha;
    var url = Uri.parse("http://localhost:8080/apiRfind/empresa/cadastrar");
    await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        "cnpj": cnpj,
        "email": email,
        "nome": nome,
        "senha": senha,
      }),
    );
  }

  Future<void> atualizar(Empresa empresa) async {
    int id = empresa.id;
    String cnpj = empresa.cnpj;
    String email = empresa.email;
    String nome = empresa.nome;
    String senha = empresa.senha;

    String idStr = id.toString();
    var url = Uri.parse("http://localhost:8080/apiRfind/empresa/atualizar");
    await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(<String, String>{
        "id": idStr,
        "cnpj": cnpj,
        "email": email,
        "nome": nome,
        "senha": senha,
      }),
    );
  }

  Future<void> excluir(int id) async {
    //trocar por cnpj
    var url = Uri.parse("http://localhost:8080/apiRfind/empresa/excluir/$id");
    await http.delete(url);
  }
}
