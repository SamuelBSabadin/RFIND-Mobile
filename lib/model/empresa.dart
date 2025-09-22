//por enquanto serve só para testes
class Empresa {
  int _id = 0;
  String _cnpj = "";
  String _email = "";
  String _nome = "";
  String _senha = "";

  static List<Empresa> empresas = [
    Empresa("11111111111111", "rfaind@gmail.com", "RFIND", "aaaaaaaa"),
  ];

  Empresa.withId(this._id, this._cnpj, this._email, this._nome, this._senha);

  Empresa(this._cnpj, this._email, this._nome, this._senha);

  set id(int id) => this._id = id;

  int get id => this._id;

  String get cnpj => this._cnpj;

  set cnpj(String value) => this._cnpj = value;

  set email(String email) => this._email = email;

  String get email => this._email;

  get nome => this._nome;

  set nome(value) => this._nome = value;

  get senha => this._senha;

  set senha(value) => this._senha = value;

  factory Empresa.fromJson(Map<String, dynamic> json) {
    return Empresa.withId(
      json['id'] ?? "",
      json['cnpj'] ?? "",
      json['email'] ?? "",
      json['nome'] ?? "",
      json['senha'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {'cnpj': cnpj, 'email': email, 'nome': nome, 'senha': senha};
  }

  //sessão de login provisório

  static String _cnpjProvisorio = "";
  static String _emailProvisorio = "";
  static String _nomeProvisorio = "";
  static String _senhaProvisoria = "";

  static String get getCnpjProvisorio => _cnpjProvisorio;

  static set cnpjProvisorio(value) => _cnpjProvisorio = value;

  static set emailProvisorio(value) => _emailProvisorio = value;

  static String get getEmailProvisorio => _emailProvisorio;

  static String get getNomeProvisorio => _nomeProvisorio;

  static set nomeProvisorio(value) => _nomeProvisorio = value;

  static String get getSenhaProvisoria => _senhaProvisoria;

  static set senhaProvisoria(value) => _senhaProvisoria = value;
}
