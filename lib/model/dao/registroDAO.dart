import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rfind_mobile/model/empresa.dart';
import 'package:rfind_mobile/model/funcionario.dart';
import 'package:rfind_mobile/model/local.dart';
import 'package:rfind_mobile/model/registro.dart';

class Registrodao {
  Future<List<dynamic>> listar() async {
    List<Registro> listaTemp = [];
    var url = Uri.parse("http://localhost:8080/apiRfind/registro/listar");
    var resposta = await http.get(url);
    var jsonData = jsonDecode(resposta.body) /*as List*/;
    for (var registro in jsonData) {
      Registro registroTemp = Registro(
        Funcionario("", "", "", "", true, "", Empresa("", "", "", "")),
        Local("", "", "", Empresa("", "", "", "")),
        "",
        "",
        "",
        "",
        Empresa("", "", "", ""),
      );
      registroTemp.id = registro["id"];
      var funcionarioJson = registro["funcionario"];
      registroTemp.funcionario = Funcionario.fromJson(funcionarioJson);
      var localJson = registro["local"];
      registroTemp.local = Local.fromJson(localJson);
      registroTemp.dataEntrada = registro["dataEntrada"];
      registroTemp.dataSaida = registro["dataSaida"];
      registroTemp.horaEntrada = registro["horaEntrada"];
      registroTemp.horaSaida = registro["horaSaida"];
      var empresaJson = registro["empresa"];
      registroTemp.empresa = Empresa.fromJson(empresaJson);
      listaTemp.add(registroTemp);
    }
    return listaTemp;
  }

  Future<void> excluir(int id) async {
    var url = Uri.parse("http://localhost:8080/apiRfind/registro/excluir/$id");
    await http.delete(url);
  }
}
