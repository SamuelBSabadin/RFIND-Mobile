import 'package:rfind_mobile/model/empresa.dart';

class Local {
  int _id = 0;
  String _nome = "";
  String _descricao = "";
  String _idrfid = "";
  //int _empresaId = 0;
  Empresa _empresa = Empresa("", "", "", "");

  set empresa(Empresa empresa) => this._empresa = empresa;
  Empresa get empresa => this._empresa;

  String get idrfid => this._idrfid ?? "";

  set idrfid(String idrfid) => this._idrfid = idrfid;

  //int get empresaId => this._empresaId;

  //set empresaId(int value) => this._empresaId = value;

  static List<Local> locais = [];

  int get id => this._id;

  set id(int id) => this._id = id;

  String get nome => this._nome ?? "";

  set nome(value) => this._nome = value;

  String get descricao => this._descricao ?? "";

  set descricao(value) => this._descricao = value;

  Local(this._nome, this._descricao, this._idrfid, this._empresa);

  Local.withId(
    this._id,
    this._nome,
    this._descricao,
    this._idrfid,
    this._empresa,
  );

  factory Local.fromJson(Map<String, dynamic> json) {
    return Local.withId(
      json["id"],
      json["nome"],
      json["descricao"],
      json["idrfid"],
      Empresa.fromJson(json["empresa"]),
    );
  }
}
