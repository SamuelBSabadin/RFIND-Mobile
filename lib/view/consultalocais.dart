import 'package:flutter/material.dart';
import 'package:rfind_mobile/control/localcontrol.dart';
import 'package:rfind_mobile/model/empresa.dart';
import 'package:rfind_mobile/model/local.dart';
import 'package:rfind_mobile/view/locais.dart';
import 'package:rfind_mobile/view/menu.dart';

class Consultalocais extends StatefulWidget {
  const Consultalocais({super.key});

  @override
  State<Consultalocais> createState() => _ConsultalocaisState();
}

TextStyle lexendExa = TextStyle(
  fontFamily: "LexendExa",
  color: Colors.white,
  fontSize: 60,
);
TextStyle openSans = TextStyle(fontFamily: "Open Sans", color: Colors.white);

TextEditingController exclusaoController = TextEditingController();
TextEditingController pesquisaController = TextEditingController();

TextEditingController idController = TextEditingController();
TextEditingController nomeController = TextEditingController();
TextEditingController descController = TextEditingController();
TextEditingController tagController = TextEditingController();

Localcontrol localcontrol = Localcontrol();

bool tagJaUsada = false;

Future<void> verificaTag(String tag) async {
  for (Local local in await localcontrol.listar()) {
    if (local.idrfid == tag) {
      tagJaUsada = true;
      break;
    }
  }
}

class _ConsultalocaisState extends State<Consultalocais> {
  List<dynamic> locais = [];
  List<dynamic> locaisFiltrados = [];
  GlobalKey<FormState> consultaLocalKey = GlobalKey<FormState>();
  GlobalKey<FormState> miniKey = GlobalKey<FormState>();
  GlobalKey<FormState> alteraKey = GlobalKey<FormState>();
  void carregarDados() async {
    List<dynamic> lista = [];
    for (var local in await localcontrol.listar()) {
      if (local.empresa.cnpj == Empresa.getCnpjProvisorio) {
        lista.add(local);
        locaisFiltrados.add(local);
      }
    }
    setState(() {
      locais = lista;
    });
  }

  void filtrarDados(String pesquisa) /*async*/ {
    List<dynamic> lista = [];
    for (var local in /*await localcontrol.listar()*/ locaisFiltrados) {
      if (local.empresa.cnpj == Empresa.getCnpjProvisorio) {
        if (local.id.toString().contains(pesquisa) ||
            local.nome.contains(pesquisa) ||
            local.descricao.contains(pesquisa) ||
            local.idrfid.contains(pesquisa)) {
          lista.add(local);
        }
      }
    }
    setState(() {
      locais = lista;
    });
  }

  void alteraLocal(Local local) async {
    if (nomeController.text != "") {
      local.nome = nomeController.text;
    }
    if (descController.text != "") {
      local.descricao = descController.text;
    }
    if (tagController.text != "") {
      local.idrfid = tagController.text;
    }
  }

  Future<List<dynamic>> filtrarPorEmpresaLogada() async {
    List<dynamic> lista = [];
    for (var local in await localcontrol.listar()) {
      if (local.empresa.cnpj == Empresa.getCnpjProvisorio) {
        lista.add(local);
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
                  'RFIND - Consultar Locais',
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
                    MaterialPageRoute(builder: (context) => Menu()),
                  );
                  pesquisaController.clear();
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
              key: consultaLocalKey,
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
                                  "Descrição",
                                  style: openSans.copyWith(color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Código RFID",
                                  style: openSans.copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                            rows: List<DataRow>.generate(
                              locais.length,
                              (int index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Text(
                                      "${locais[index].id}",
                                      style: openSans.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      locais[index].nome,
                                      style: openSans.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      locais[index].descricao,
                                      style: openSans.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      locais[index].idrfid,
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
                                          "Alterar local",
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
                                                        "ID do local",
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
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: 40),
                                                  TextFormField(
                                                    controller: nomeController,
                                                    decoration: InputDecoration(
                                                      label: Text(
                                                        "Nome do local",
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
                                                    controller: descController,
                                                    decoration: InputDecoration(
                                                      label: Text(
                                                        "Descrição do local",
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
                                                      /*if (tagJaUsada) {
                                                        return "Já há um local com essa tag!";
                                                      }*/
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: 40),
                                                  ElevatedButton(
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                          minimumSize: Size(
                                                            200,
                                                            50,
                                                          ),
                                                        ),
                                                    onPressed: () async {
                                                      await verificaTag(
                                                        tagController.text,
                                                      );
                                                      if (tagJaUsada) {
                                                        setState(() {});
                                                      }
                                                      bool localElegivel =
                                                          false;
                                                      if (alteraKey
                                                          .currentState!
                                                          .validate()) {
                                                        Local local = Local(
                                                          "",
                                                          "",
                                                          "",
                                                          Empresa("", "", ""),
                                                        );
                                                        for (var localTemp
                                                            in await filtrarPorEmpresaLogada()) {
                                                          if (localTemp.id ==
                                                              int.parse(
                                                                idController
                                                                    .text,
                                                              )) {
                                                            local = localTemp;
                                                            localElegivel =
                                                                true;
                                                            break;
                                                          }
                                                        }
                                                        if (localElegivel) {
                                                          alteraLocal(local);
                                                          await localcontrol
                                                              .atualizar(local);
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
                                                                      "Local alterado com sucesso!",
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
                                                                        descController
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
                                                                      "Não foi encontrado nenhum local com esse ID!",
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
                                                                        descController
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
                                                      "Alterar local",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
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
                                              descController.clear();
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
                                'Alterar local',
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
                                          "Excluir local",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Color(0xff20232a),
                                        content: SizedBox(
                                          height: 140,
                                          width: 384,
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
                                                          "Digite o ID do local",
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
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                          minimumSize: Size(
                                                            200,
                                                            50,
                                                          ),
                                                        ),
                                                    onPressed: () async {
                                                      if (miniKey.currentState!
                                                          .validate()) {
                                                        bool localElegivel =
                                                            false;
                                                        List<dynamic> temp =
                                                            await filtrarPorEmpresaLogada();
                                                        if (temp.isNotEmpty) {
                                                          for (var local
                                                              in temp) {
                                                            if (local.id ==
                                                                int.parse(
                                                                  exclusaoController
                                                                      .text,
                                                                )) {
                                                              localElegivel =
                                                                  true;
                                                              break;
                                                            }
                                                          }
                                                        }
                                                        if (localElegivel) {
                                                          await localcontrol
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
                                                                      "Local excluído com sucesso!",
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
                                                                      "Não foi encontrado um local com esse ID!",
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
                                                        fontSize: 18,
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
                                setState(() {
                                  carregarDados();
                                });
                              },
                              child: Text(
                                'Excluir local',
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
            ),
          ),
        ),
      ),
    );
  }
}
