import 'package:rfind_mobile/model/empresa.dart';

class Produto {
  int _id = 0;
  String _nome = "";
  String _categoria = "";
  String _dataFabricacao = "";
  String _dataValidade = "";
  String _descricao = "";
  String _fornecedor = "";
  double _preco = 0;
  int _qtdEstoque = 0;
  bool _ativado = false;
  Empresa _empresa = Empresa("", "", "", "");

  Empresa get empresa => this._empresa;
  set empresa(Empresa empresa) => this._empresa = empresa;

  static List<Produto> produtos = [];

  bool get ativado => this._ativado;

  set ativado(bool value) => this._ativado = value;

  int get id => this._id;

  set id(int value) => this._id = value;

  String get nome => this._nome ?? "";

  set nome(value) => this._nome = value;

  String get categoria => this._categoria ?? "";

  set categoria(value) => this._categoria = value;

  String get dataFabricacao => this._dataFabricacao ?? "";

  set dataFabricacao(value) => this._dataFabricacao = value;

  String get dataValidade => this._dataValidade ?? "";

  set dataValidade(value) => this._dataValidade = value;

  String get descricao => this._descricao ?? "";

  set descricao(value) => this._descricao = value;

  String get fornecedor => this._fornecedor ?? "";

  set fornecedor(value) => this._fornecedor = value;

  double get preco => this._preco;

  set preco(value) => this._preco = value;

  int get qtdEstoque => this._qtdEstoque;

  set qtdEstoque(value) => this._qtdEstoque = value;

  Produto(
    this._nome,
    this._categoria,
    this._dataFabricacao,
    this._dataValidade,
    this._descricao,
    this._fornecedor,
    this._preco,
    this._qtdEstoque,
    this._ativado,
    this._empresa,
  );

  Produto.empty();

  Produto.withId(
    this._id,
    this._nome,
    this._categoria,
    this._dataFabricacao,
    this._dataValidade,
    this._descricao,
    this._fornecedor,
    this._preco,
    this._qtdEstoque,
    this._ativado,
    this._empresa,
  );
}
