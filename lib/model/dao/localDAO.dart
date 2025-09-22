import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rfind_mobile/model/empresa.dart';
import 'package:rfind_mobile/model/local.dart';

class Localdao {
  Future<List<dynamic>> listar() async {
    var url = Uri.parse("http://localhost:8080/apiRfind/local/listar");
    var resposta = await http.get(url);
    var jsonData = jsonDecode(resposta.body);
    List<dynamic> listaTemp = [];
    for (var local in jsonData) {
      Local localTemp = Local("", "", "", Empresa("", "", "", ""));
      localTemp.id = local["id"];
      localTemp.nome = local["nome"];
      localTemp.descricao = local["descricao"];
      localTemp.idrfid = local["idrfid"];
      var empresaJson = local["empresa"];
      localTemp.empresa = Empresa.fromJson(empresaJson);
      listaTemp.add(localTemp);
    }
    return listaTemp;
  }

  Future<void> atualizar(Local local) async {
    String id = local.id.toString();
    String nome = local.nome;
    String descricao = local.descricao;
    String idRfid = local.idrfid;
    String empresa_id = local.empresa.id.toString();
    var url = Uri.parse("http://localhost:8080/apiRfind/local/atualizar");
    await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        "id": id,
        "descricao": descricao,
        "nome": nome,
        "idrfid": idRfid,
        "empresa": {"id": empresa_id},
      }),
    );
  }

  Future<void> cadastrar(Local local) async {
    String nome = local.nome;
    String descricao = local.descricao;
    String idRfid = local.idrfid;
    String empresa_id = local.empresa.id.toString();
    var url = Uri.parse("http://localhost:8080/apiRfind/local/cadastrar");
    await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        "descricao": descricao,
        "nome": nome,
        "idrfid": idRfid,
        "empresa": {"id": empresa_id},
      }),
    );
  }

  Future<void> excluir(int id) async {
    var url = Uri.parse("http://localhost:8080/apiRfind/local/excluir/$id");
    await http.delete(url);
  }
}
