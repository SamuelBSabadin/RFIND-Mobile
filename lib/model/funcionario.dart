import 'package:rfind_mobile/model/empresa.dart';

class Funcionario {
  int _id = 0;
  String _nome = "";
  String _sobrenome = "";
  String _cpf = "";
  String _setor = "";
  bool _ativado = false;
  String _tagRfid = "";
  Empresa _empresa = Empresa("", "", "", "");

  Empresa get empresa => this._empresa;
  set empresa(Empresa empresa) => this._empresa = empresa;

  bool get ativado => this._ativado;

  set ativado(bool value) => this._ativado = value;

  String get tagRfid => this._tagRfid;

  set tagRfid(String value) => this._tagRfid = value;

  static List<Funcionario> funcionarios = [];

  Funcionario(
    this._nome,
    this._sobrenome,
    this._cpf,
    this._setor,
    this._ativado,
    this._tagRfid,
    this._empresa,
  );

  Funcionario.empty();

  Funcionario.withId(
    this._id,
    this._nome,
    this._sobrenome,
    this._cpf,
    this._setor,
    this._ativado,
    this._tagRfid,
    this._empresa,
  );

  factory Funcionario.fromJson(Map<String, dynamic> json) {
    return Funcionario.withId(
      json["id"],
      json["nome"],
      json["sobrenome"],
      json["cpf"],
      json["setor"],
      json["ativado"],
      json["tagRfid"],
      Empresa.fromJson(json["empresa"]),
    );
  }

  set nome(String nome) => this._nome = nome;
  set sobrenome(String sobrenome) => this._sobrenome = sobrenome;
  set cpf(String cpf) => this._cpf = cpf;
  set setor(String setor) => this._setor = setor;
  set id(int id) => this._id = id;

  int get id => this._id;
  String get nome => this._nome ?? "";
  String get sobrenome => this._sobrenome ?? "";
  String get cpf => this._cpf ?? "";
  String get setor => this._setor ?? "";
}
