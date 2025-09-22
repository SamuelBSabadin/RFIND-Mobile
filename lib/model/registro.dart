import 'package:rfind_mobile/model/empresa.dart';
import 'package:rfind_mobile/model/funcionario.dart';
import 'package:rfind_mobile/model/local.dart';

class Registro {
  int _id = 0;
  Funcionario _funcionario = Funcionario.empty();
  Local _local = Local("", "", "", Empresa("", "", "", ""));
  String _dataEntrada = "";
  String _dataSaida = "";
  String _horaEntrada = "";
  String _horaSaida = "";
  Empresa _empresa = Empresa("", "", "", "");

  List<Registro> registros = [];

  Registro.withId(
    this._id,
    this._funcionario,
    this._local,
    this._dataEntrada,
    this._dataSaida,
    this._horaEntrada,
    this._horaSaida,
    this._empresa,
  );

  Registro.empty();

  Registro(
    this._funcionario,
    this._local,
    this._dataEntrada,
    this._dataSaida,
    this._horaEntrada,
    this._horaSaida,
    this._empresa,
  );

  int get id => this._id;

  set id(int id) => this._id = id;

  Funcionario get funcionario => this._funcionario;

  set funcionario(Funcionario funcionario) => this._funcionario = funcionario;

  Local get local => this._local;

  set local(Local local) => this._local = local;

  String get dataEntrada => this._dataEntrada ?? "";

  set dataEntrada(value) => this._dataEntrada = value;

  String get dataSaida => this._dataSaida ?? "";

  set dataSaida(value) => this._dataSaida = value;

  String get horaEntrada => this._horaEntrada ?? "";

  set horaEntrada(value) => this._horaEntrada = value;

  String get horaSaida => this._horaSaida ?? "";

  set horaSaida(value) => this._horaSaida = value;

  Empresa get empresa => this._empresa;

  set empresa(Empresa empresa) => this._empresa = empresa;
}
