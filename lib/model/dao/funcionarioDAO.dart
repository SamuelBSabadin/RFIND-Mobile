import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rfind_mobile/model/empresa.dart';
import 'package:rfind_mobile/model/funcionario.dart';

class Funcionariodao {
  Future<List<dynamic>> listar() async {
    var url = Uri.parse("http://localhost:8080/apiRfind/funcionario/listar");
    var resposta = await http.get(url);
    var jsonData = jsonDecode(resposta.body);
    List<dynamic> listaTemp = [];
    for (var funcionario in jsonData) {
      Funcionario funcionariotemp = Funcionario.empty();
      funcionariotemp.id = funcionario["id"];
      funcionariotemp.nome = funcionario["nome"];
      funcionariotemp.sobrenome = funcionario["sobrenome"];
      funcionariotemp.cpf = funcionario["cpf"];
      funcionariotemp.setor = funcionario["setor"];
      funcionariotemp.ativado = funcionario["ativado"];
      funcionariotemp.tagRfid = funcionario["tagRfid"];
      var empresaJson = funcionario["empresa"];
      funcionariotemp.empresa = Empresa.fromJson(empresaJson);

      listaTemp.add(funcionariotemp);
    }
    return listaTemp;
  }

  Future<void> cadastrar(Funcionario funcionario) async {
    String nome = funcionario.nome;
    String sobrenome = funcionario.sobrenome;
    String cpf = funcionario.cpf;
    String setor = funcionario.setor;
    String ativado = funcionario.ativado.toString();
    String tagRfid = funcionario.tagRfid;
    String empresa_id = funcionario.empresa.id.toString();
    var url = Uri.parse("http://localhost:8080/apiRfind/funcionario/cadastrar");
    await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: (jsonEncode(<String, dynamic>{
        'nome': nome,
        'sobrenome': sobrenome,
        'cpf': cpf,
        'setor': setor,
        'ativado': ativado,
        'tagRfid': tagRfid,
        'empresa': {'id': empresa_id},
      })),
    );
  }

  Future<void> atualizar(Funcionario funcionario) async {
    String id = funcionario.id.toString();
    String nome = funcionario.nome;
    String sobrenome = funcionario.sobrenome;
    String cpf = funcionario.cpf;
    String setor = funcionario.setor;
    String ativado = funcionario.ativado.toString();
    String tagRfid = funcionario.tagRfid;
    int empresa_id = funcionario.empresa.id;
    var url = Uri.parse("http://localhost:8080/apiRfind/funcionario/atualizar");
    await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: (jsonEncode(<String, dynamic>{
        'id': id,
        'nome': nome,
        'sobrenome': sobrenome,
        'cpf': cpf,
        'setor': setor,
        'ativado': ativado,
        'tagRfid': tagRfid,
        'empresa': {'id': empresa_id},
      })),
    );
  }

  Future<void> excluir(int id) async {
    var url = Uri.parse(
      "http://localhost:8080/apiRfind/funcionario/excluir/$id",
    );
    await http.delete(url);
  }
}
