import 'package:flutter/material.dart';
import 'package:rfind_mobile/control/funcionariocontrol.dart';
import 'package:rfind_mobile/model/funcionario.dart';
import 'package:rfind_mobile/view/funcionarios.dart';

class Consultadesativados extends StatefulWidget {
  const Consultadesativados({super.key});

  @override
  State<Consultadesativados> createState() => _ConsultadesativadosState();
}

TextStyle lexendExa = TextStyle(
  fontFamily: "LexendExa",
  color: Colors.white,
  fontSize: 60,
);
TextStyle openSans = TextStyle(fontFamily: "Open Sans", color: Colors.white);

TextEditingController exclusaoController = TextEditingController();
TextEditingController reativaController = TextEditingController();
TextEditingController pesquisaController = TextEditingController();
TextEditingController tagController = TextEditingController();

TextEditingController idController = TextEditingController();
TextEditingController nomeController = TextEditingController();
TextEditingController sobrenomeController = TextEditingController();
TextEditingController setorController = TextEditingController();

Funcionariocontrol funcionariocontrol = Funcionariocontrol();

class _ConsultadesativadosState extends State<Consultadesativados> {
  List<dynamic> funcionarios = [];
  List<dynamic> funcionariosFiltrados = [];
  GlobalKey<FormState> consultaFuncKey = GlobalKey<FormState>();
  GlobalKey<FormState> miniKey = GlobalKey<FormState>();
  GlobalKey<FormState> alteraKey = GlobalKey<FormState>();
  void carregarDados() async {
    List<dynamic> lista = [];
    for (var funcionario
        in await funcionariocontrol.filtraPorEmpresaLogadaDesativados()) {
      //if (funcionario.empresa.cnpj == Empresa.getCnpjProvisorio) {
      lista.add(funcionario);
      funcionariosFiltrados.add(funcionario);
      //}
    }
    setState(() {
      funcionarios = lista;
    });
  }

  void filtrarDados(String pesquisa) async {
    List<dynamic> lista = [];
    for (var funcionario
        in /*await funcionariocontrol.filtraPorEmpresaLogadaDesativados()*/ funcionariosFiltrados) {
      //if (funcionario.empresa.cnpj == Empresa.getCnpjProvisorio) {
      if (funcionario.id.toString().contains(pesquisa) ||
          funcionario.nome.contains(pesquisa) ||
          funcionario.sobrenome.contains(pesquisa) ||
          funcionario.cpf.contains(pesquisa) ||
          funcionario.setor.contains(pesquisa)) {
        lista.add(funcionario);
        //}
      }
    }
    setState(() {
      funcionarios = lista;
    });
  }

  void alteraFuncionario(Funcionario funcionario) async {
    if (nomeController.text != "") {
      funcionario.nome = nomeController.text;
    }
    if (sobrenomeController.text != "") {
      funcionario.sobrenome = sobrenomeController.text;
    }
    if (setorController.text != "") {
      funcionario.setor = setorController.text;
    }
    if (tagController.text != "") {
      funcionario.tagRfid = tagController.text;
    }
  }

  /*Future<List<dynamic>> filtraPorEmpresaLogada() async {
    List<dynamic> lista = [];
    for (var funcionario in await funcionariocontrol.listar()) {
      if (funcionario.empresa.cnpj == Empresa.getCnpjProvisorio &&
          funcionario.ativado == false) {
        lista.add(funcionario);
      }
    }
    return lista;
  }*/

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
                  'RFIND - Consultar Funcionários Desativados',
                  style: openSans.copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
              /*ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Configs()),
                  );
                  pesquisaController.clear();
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
                  pesquisaController.clear();
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
                    MaterialPageRoute(builder: (context) => Funcionarios()),
                  );
                  pesquisaController.clear();
                },
                leading: Icon(Icons.arrow_back, color: Colors.white),
                title: Text(
                  'Voltar',
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
              key: consultaFuncKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: <DataColumn>[
                              DataColumn(
                                label: Text(
                                  "ID",
                                  style: openSans.copyWith(color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Nome",
                                  style: openSans.copyWith(color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Sobrenome",
                                  style: openSans.copyWith(color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "CPF",
                                  style: openSans.copyWith(color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Setor",
                                  style: openSans.copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                            rows: List<DataRow>.generate(
                              funcionarios.length,
                              (int index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Text(
                                      "${funcionarios[index].id}",
                                      style: openSans.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      funcionarios[index].nome,
                                      style: openSans.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      funcionarios[index].sobrenome,
                                      style: openSans.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      funcionarios[index].cpf,
                                      style: openSans.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      funcionarios[index].setor,
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

                        /*SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(200, 50),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => AlertDialog(
                                        title: Text(
                                          "Excluir funcionário",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Color(0xff20232a),
                                        content: SizedBox(
                                          width: 384,
                                          height: 140,
                                          child: Container(
                                            color: Color(0xff20232a),
                                            child: Form(
                                              key: miniKey,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller:
                                                        exclusaoController,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          "Digite o ID do funcionário",
                                                      labelStyle: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Digite o ID a ser excluído!";
                                                      }
                                                      var temLetra = RegExp(
                                                        r'[A-Za-zÀ-ÿ]',
                                                      );
                                                      if (temLetra.hasMatch(
                                                        value,
                                                      )) {
                                                        return "Digite apenas números!";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: 40),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      bool funcionarioElegivel =
                                                          false;
                                                      if (miniKey.currentState!
                                                          .validate()) {
                                                        List<dynamic> temp =
                                                            await funcionariocontrol
                                                                .filtraPorEmpresaLogadaDesativados();
                                                        if (temp.isEmpty) {
                                                        } else {
                                                          for (var funcionario
                                                              in temp) {
                                                            if (funcionario
                                                                    .id ==
                                                                int.parse(
                                                                  exclusaoController
                                                                      .text,
                                                                )) {
                                                              funcionarioElegivel =
                                                                  true;
                                                              break;
                                                            }
                                                          }
                                                        }
                                                        if (funcionarioElegivel ==
                                                            true) {
                                                          await funcionariocontrol
                                                              .excluir(
                                                                int.parse(
                                                                  exclusaoController
                                                                      .text,
                                                                ),
                                                              );
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (
                                                                  context,
                                                                ) => AlertDialog(
                                                                  backgroundColor:
                                                                      Color(
                                                                        0xff20232a,
                                                                      ),
                                                                  title: Text(
                                                                    "Êxito",
                                                                    style: TextStyle(
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                    ),
                                                                  ),
                                                                  content: Container(
                                                                    color: Color(
                                                                      0xff20232a,
                                                                    ),
                                                                    child: Text(
                                                                      "Funcionário excluído com sucesso!",
                                                                      style: TextStyle(
                                                                        color:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        miniKey
                                                                            .currentState!
                                                                            .reset();
                                                                        exclusaoController
                                                                            .clear();
                                                                        Navigator.of(
                                                                          context,
                                                                        ).pop();
                                                                      },
                                                                      child: Text(
                                                                        "Voltar",
                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                          );
                                                        } else {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (
                                                                  context,
                                                                ) => AlertDialog(
                                                                  backgroundColor:
                                                                      Color(
                                                                        0xff20232a,
                                                                      ),
                                                                  title: Text(
                                                                    "Falha",
                                                                    style: TextStyle(
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                    ),
                                                                  ),
                                                                  content: Container(
                                                                    color: Color(
                                                                      0xff20232a,
                                                                    ),
                                                                    child: Text(
                                                                      "Não foi encontrado um funcionário com esse ID!",
                                                                      style: TextStyle(
                                                                        color:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        miniKey
                                                                            .currentState!
                                                                            .reset();
                                                                        exclusaoController
                                                                            .clear();
                                                                        Navigator.of(
                                                                          context,
                                                                        ).pop();
                                                                      },
                                                                      child: Text(
                                                                        "Voltar",
                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                          );
                                                        }
                                                        setState(() {
                                                          carregarDados();
                                                        });
                                                      }
                                                    },
                                                    child: Text(
                                                      "Excluir",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              miniKey.currentState!.reset();
                                              exclusaoController.clear();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Voltar",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                );
                              },
                              child: Text(
                                'Excluir funcionário',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            //começa aqui
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(200, 50),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => AlertDialog(
                                        title: Text(
                                          "Reativar funcionário",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Color(0xff20232a),
                                        content: SizedBox(
                                          width: 384,
                                          height: 140,
                                          child: Container(
                                            color: Color(0xff20232a),
                                            child: Form(
                                              key: miniKey,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller:
                                                        reativaController,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          "Digite o ID do funcionário",
                                                      labelStyle: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Digite o ID a ser reativado!";
                                                      }
                                                      var temLetra = RegExp(
                                                        r'[A-Za-zÀ-ÿ]',
                                                      );
                                                      if (temLetra.hasMatch(
                                                        value,
                                                      )) {
                                                        return "Digite apenas números!";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: 40),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      bool funcionarioElegivel =
                                                          false;
                                                      if (miniKey.currentState!
                                                          .validate()) {
                                                        List<dynamic> temp =
                                                            await funcionariocontrol
                                                                .filtraPorEmpresaLogadaDesativados();
                                                        if (temp.isEmpty) {
                                                        } else {
                                                          for (var funcionario
                                                              in temp) {
                                                            if (funcionario
                                                                    .id ==
                                                                int.parse(
                                                                  reativaController
                                                                      .text,
                                                                )) {
                                                              funcionarioElegivel =
                                                                  true;
                                                              break;
                                                            }
                                                          }
                                                        }
                                                        if (funcionarioElegivel ==
                                                            true) {
                                                          await funcionariocontrol
                                                              .reativar(
                                                                int.parse(
                                                                  reativaController
                                                                      .text,
                                                                ),
                                                              );
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (
                                                                  context,
                                                                ) => AlertDialog(
                                                                  backgroundColor:
                                                                      Color(
                                                                        0xff20232a,
                                                                      ),
                                                                  title: Text(
                                                                    "Êxito",
                                                                    style: TextStyle(
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                    ),
                                                                  ),
                                                                  content: Container(
                                                                    color: Color(
                                                                      0xff20232a,
                                                                    ),
                                                                    child: Text(
                                                                      "Funcionário Reativado com sucesso!",
                                                                      style: TextStyle(
                                                                        color:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        miniKey
                                                                            .currentState!
                                                                            .reset();
                                                                        reativaController
                                                                            .clear();
                                                                        Navigator.of(
                                                                          context,
                                                                        ).pop();
                                                                      },
                                                                      child: Text(
                                                                        "Voltar",
                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                          );
                                                        } else {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (
                                                                  context,
                                                                ) => AlertDialog(
                                                                  backgroundColor:
                                                                      Color(
                                                                        0xff20232a,
                                                                      ),
                                                                  title: Text(
                                                                    "Falha",
                                                                    style: TextStyle(
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                    ),
                                                                  ),
                                                                  content: Container(
                                                                    color: Color(
                                                                      0xff20232a,
                                                                    ),
                                                                    child: Text(
                                                                      "Não foi encontrado um funcionário com esse ID!",
                                                                      style: TextStyle(
                                                                        color:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        miniKey
                                                                            .currentState!
                                                                            .reset();
                                                                        reativaController
                                                                            .clear();
                                                                        Navigator.of(
                                                                          context,
                                                                        ).pop();
                                                                      },
                                                                      child: Text(
                                                                        "Voltar",
                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                          );
                                                        }
                                                        setState(() {
                                                          carregarDados();
                                                        });
                                                      }
                                                    },
                                                    child: Text(
                                                      "Reativar",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              miniKey.currentState!.reset();
                                              reativaController.clear();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "Voltar",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                );
                              },
                              child: Text(
                                "Reativar funcionário",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),*/
                        SizedBox(height: 40),
                        TextFormField(
                          controller: pesquisaController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            prefixIcon: Icon(Icons.search, color: Colors.white),
                            labelText: 'Filtro',
                            labelStyle: openSans.copyWith(color: Colors.white),
                          ),
                          style: openSans.copyWith(color: Colors.white),
                          onChanged: (value) {
                            filtrarDados(value);
                          },
                        ),
                        SizedBox(height: 40),
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
