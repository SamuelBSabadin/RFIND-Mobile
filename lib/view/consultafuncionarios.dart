import 'package:flutter/material.dart';
import 'package:rfind_mobile/control/funcionariocontrol.dart';
import 'package:rfind_mobile/model/funcionario.dart';
import 'package:rfind_mobile/view/funcionarios.dart';

class Consultafuncionarios extends StatefulWidget {
  const Consultafuncionarios({super.key});

  @override
  State<Consultafuncionarios> createState() => _ConsultafuncionariosState();
}

TextStyle lexendExa = TextStyle(
  fontFamily: "LexendExa",
  color: Colors.white,
  fontSize: 60,
);
TextStyle openSans = TextStyle(fontFamily: "Open Sans", color: Colors.white);

TextEditingController exclusaoController = TextEditingController();
TextEditingController pesquisaController = TextEditingController();
TextEditingController tagController = TextEditingController();

TextEditingController idController = TextEditingController();
TextEditingController nomeController = TextEditingController();
TextEditingController sobrenomeController = TextEditingController();
TextEditingController setorController = TextEditingController();

Funcionariocontrol funcionariocontrol = Funcionariocontrol();

class _ConsultafuncionariosState extends State<Consultafuncionarios> {
  bool tagExiste = false;

  Future<void> verificaTag(String tag) async {
    for (Funcionario f in await funcionariocontrol.listar()) {
      if (f.tagRfid == tag) {
        tagExiste = true;
        break;
      }
    }
  }

  List<Funcionario> funcionarios = [];
  List<Funcionario> funcionariosFiltrados = [];
  GlobalKey<FormState> consultaFuncKey = GlobalKey<FormState>();
  GlobalKey<FormState> miniKey = GlobalKey<FormState>();
  GlobalKey<FormState> alteraKey = GlobalKey<FormState>();
  void carregarDados() async {
    List<Funcionario> lista = [];
    for (var funcionario
        in await funcionariocontrol.filtraPorEmpresaLogadaAtivados()) {
      //if (funcionario.empresa.cnpj == Empresa.getCnpjProvisorio) {
      lista.add(funcionario);
      funcionariosFiltrados.add(funcionario);
      //}
    }
    setState(() {
      funcionarios = lista;
    });
  }

  void filtrarDados(String pesquisa) /*async*/ {
    List<Funcionario> lista = [];
    for (var funcionario
        in /*await funcionariocontrol.filtraPorEmpresaLogadaAtivados()*/ funcionariosFiltrados) {
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
          funcionario.ativado == true) {
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
                  'RFIND - Consultar Funcionários',
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
                                        backgroundColor: Color(0xff20232a),
                                        title: Text(
                                          "Alterar funcionário",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        content: SingleChildScrollView(
                                          child: Container(
                                            width: 384,
                                            color: Color(0xff20232a),
                                            child: Form(
                                              key: alteraKey,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: idController,
                                                    decoration: InputDecoration(
                                                      label: Text(
                                                        "ID do funcionário",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "O campo não pode ser vazio!";
                                                      }
                                                      var temLetra = RegExp(
                                                        r'[A-Za-zÀ-ÿ]',
                                                      );
                                                      if (temLetra.hasMatch(
                                                        value,
                                                      )) {
                                                        return "O ID não pode conter letras!";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: 40),
                                                  TextFormField(
                                                    controller: nomeController,
                                                    decoration: InputDecoration(
                                                      label: Text(
                                                        "Nome do funcionário",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    validator: (value) {
                                                      var temNumero = RegExp(
                                                        r'\d',
                                                      );

                                                      if (temNumero.hasMatch(
                                                        value!,
                                                      )) {
                                                        return 'O nome não pode conter números';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: 40),
                                                  TextFormField(
                                                    controller:
                                                        sobrenomeController,
                                                    decoration: InputDecoration(
                                                      label: Text(
                                                        "Sobrenome do funcionário",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    validator: (value) {
                                                      var temNumero = RegExp(
                                                        r'\d',
                                                      );

                                                      if (temNumero.hasMatch(
                                                        value!,
                                                      )) {
                                                        return 'O sobrenome não pode conter números';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: 40),
                                                  TextFormField(
                                                    controller: setorController,
                                                    decoration: InputDecoration(
                                                      label: Text(
                                                        "Setor do funcionário",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    validator: (value) {
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: 40),
                                                  TextFormField(
                                                    controller: tagController,
                                                    decoration: InputDecoration(
                                                      label: Text(
                                                        "Tag do RFID",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    validator: (value) {
                                                      if (tagExiste) {
                                                        return "Já há um funcionário com essa tag!";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: 40),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      await verificaTag(
                                                        tagController.text,
                                                      );
                                                      if (tagExiste) {
                                                        setState(() {});
                                                      }
                                                      if (alteraKey
                                                          .currentState!
                                                          .validate()) {
                                                        bool
                                                        funcionarioElegivel =
                                                            false;
                                                        Funcionario
                                                        funcionario =
                                                            Funcionario(
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              true,
                                                              "",
                                                              Empresa(
                                                                "",
                                                                "",
                                                                "",
                                                              ),
                                                            );
                                                        for (var funcionarioTemp
                                                            in await funcionariocontrol
                                                                .filtraPorEmpresaLogadaAtivados()) {
                                                          if (funcionarioTemp
                                                                  .id ==
                                                              int.parse(
                                                                idController
                                                                    .text,
                                                              )) {
                                                            funcionario =
                                                                funcionarioTemp;
                                                            funcionarioElegivel =
                                                                true;
                                                            break;
                                                          }
                                                        }
                                                        if (funcionarioElegivel) {
                                                          alteraFuncionario(
                                                            funcionario,
                                                          );
                                                          await funcionariocontrol
                                                              .atualizar(
                                                                funcionario,
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
                                                                      "Funcionário alterado com sucesso!",
                                                                      style: TextStyle(
                                                                        color:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        alteraKey
                                                                            .currentState!
                                                                            .reset();
                                                                        nomeController
                                                                            .clear();
                                                                        sobrenomeController
                                                                            .clear();
                                                                        setorController
                                                                            .clear();
                                                                        idController
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
                                                                      "Não foi encontrado nenhum funcionário com esse ID!",
                                                                      style: TextStyle(
                                                                        color:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        alteraKey
                                                                            .currentState!
                                                                            .reset();
                                                                        nomeController
                                                                            .clear();
                                                                        sobrenomeController
                                                                            .clear();
                                                                        setorController
                                                                            .clear();
                                                                        idController
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
                                                      "Alterar funcionário",
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
                                              alteraKey.currentState!.reset();
                                              idController.clear();
                                              nomeController.clear();
                                              sobrenomeController.clear();
                                              setorController.clear();
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
                                'Alterar funcionário',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
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
                                          "Desativar funcionário",
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
                                                        return "Digite o ID a ser desativado!";
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
                                                                .filtraPorEmpresaLogadaAtivados();
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
                                                              .desativar(
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
                                                                      "Funcionário desativado com sucesso!",
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
                                                      "Desativar",
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
                                'Desativar funcionário',
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
