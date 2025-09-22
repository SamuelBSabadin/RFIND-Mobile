import 'package:flutter/material.dart';
import 'package:rfind_mobile/control/registrocontrol.dart';
import 'package:rfind_mobile/model/empresa.dart';
import 'package:rfind_mobile/model/registro.dart';
import 'package:rfind_mobile/view/configs.dart';
import 'package:rfind_mobile/view/menu.dart';
import 'package:rfind_mobile/view/perfil.dart';

class Gerenciamentoregistros extends StatefulWidget {
  const Gerenciamentoregistros({super.key});

  @override
  State<Gerenciamentoregistros> createState() => _GerenciamentoregistrosState();
}

TextStyle lexendExa = TextStyle(
  fontFamily: "LexendExa",
  color: Colors.white,
  fontSize: 60,
);
TextStyle openSans = TextStyle(fontFamily: "Open Sans", color: Colors.white);

Registrocontrol registrocontrol = Registrocontrol();

class _GerenciamentoregistrosState extends State<Gerenciamentoregistros> {
  GlobalKey<FormState> gerRegKey = GlobalKey<FormState>();

  List<Registro> registros = [];
  List<Registro> registrosFiltrados = [];

  void carregarDados() async {
    List<Registro> lista = [];
    for (var registro in await registrocontrol.listar()) {
      if (registro.empresa.cnpj == Empresa.getCnpjProvisorio) {
        lista.add(registro);
        registrosFiltrados.add(registro);
      }
    }
    setState(() {
      registros = lista;
    });
  }

  void filtrarDados(String pesquisa) /*async*/ {
    List<Registro> lista = [];
    for (var registro
        in /*await registrocontrol.listar()*/ registrosFiltrados) {
      if (registro.empresa.cnpj == Empresa.getCnpjProvisorio) {
        if (registro.funcionario.id.toString().contains(pesquisa) ||
            registro.funcionario.nome.contains(pesquisa) ||
            registro.funcionario.sobrenome.contains(pesquisa) ||
            registro.local.nome.contains(pesquisa) ||
            registro.horaEntrada.contains(pesquisa) ||
            registro.horaSaida.contains(pesquisa) ||
            registro.dataEntrada.contains(pesquisa) ||
            registro.dataSaida.contains(pesquisa)) {
          lista.add(registro);
        }
      }
    }
    setState(() {
      registros = lista;
    });
  }

  /*void carregarDados() async {
    List<Registro> lista = [];
    for (var registro in await registrocontrol.listar()) {
      if (registro.empresa.cnpj == Empresa.getCnpjProvisorio) {
        lista.add(registro);
        //registrosFiltrados.add(registro);
      }
    }
    setState(() {
      registros = lista;
    });
  }

  void filtrarDados(String pesquisa) async {
    List<Registro> lista = [];
    for (var registro in await registrocontrol.listar()) {
      if (registro.empresa.cnpj == Empresa.getCnpjProvisorio) {
        if (registro.funcionario.id.toString().contains(pesquisa) ||
            registro.funcionario.nome.contains(pesquisa) ||
            registro.funcionario.sobrenome.contains(pesquisa) ||
            registro.local.nome.contains(pesquisa) ||
            registro.horaEntrada.contains(pesquisa) ||
            registro.horaSaida.contains(pesquisa) ||
            registro.dataEntrada.contains(pesquisa) ||
            registro.dataSaida.contains(pesquisa)) {
          lista.add(registro);
        }
      }
    }
    setState(() {
      registros = lista;
    });
  }*/

  Future<List<Registro>> filtraPorEmpresaLogada() async {
    List<Registro> lista = [];
    for (var registro in await registrocontrol.listar()) {
      if (registro.empresa.cnpj == Empresa.getCnpjProvisorio) {
        lista.add(registro);
      }
    }
    return lista;
  }

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        toolbarHeight: 100,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'RFI', style: lexendExa),
              TextSpan(
                text: 'N',
                style: lexendExa.copyWith(color: Color(0xFF8D1F32)),
              ),
              TextSpan(text: 'D', style: lexendExa),
            ],
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xFF20232a),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(17),
                color: Color(0xff20232a),
                child: Text(
                  'RFIND - Gerenciar Registros',
                  style: openSans.copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
              /*ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Configs()),
                  );
                },
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text(
                  'Configurações',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Perfil()),
                  );
                },
                leading: Icon(Icons.apartment, color: Colors.white),
                title: Text(
                  'Minha empresa',
                  style: TextStyle(color: Colors.white),
                ),
              ),*/
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Menu()),
                  );
                },
                leading: Icon(Icons.arrow_back, color: Colors.white),
                title: Text(
                  'Voltar ao menu principal',
                  style: openSans.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            //color: Color(0xFF20232A),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Color(0xff2C2D38)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Form(
              key: gerRegKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      "ID Func",
                                      style: openSans.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Funcionário",
                                      style: openSans.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Local",
                                      style: openSans.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Entrada",
                                      style: openSans.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Saída",
                                      style: openSans.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                  registros.length,
                                  (int index) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                        Text(
                                          "${registros[index].funcionario.id}",
                                          style: openSans.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          registros[index].funcionario.nome,
                                          style: openSans.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          registros[index].local.nome,
                                          style: openSans.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          "${registros[index].dataEntrada} - ${registros[index].horaEntrada}",
                                          style: openSans.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          "${registros[index].dataSaida} - ${registros[index].horaSaida}",
                                          style: openSans.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search, color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            labelText: 'Filtro',
                            labelStyle: openSans.copyWith(color: Colors.white),
                          ),
                          style: openSans.copyWith(color: Colors.white),
                          onChanged: (value) => filtrarDados(value),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //),
            ),
          ),
        ),
      ),
    );
  }
}
