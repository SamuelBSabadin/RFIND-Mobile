import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rfind_mobile/control/empresacontrol.dart';
import 'package:rfind_mobile/control/produtocontrol.dart';
import 'package:rfind_mobile/model/produto.dart';
import 'package:rfind_mobile/view/produtos.dart';

class Consproddesativados extends StatefulWidget {
  const Consproddesativados({super.key});

  @override
  State<Consproddesativados> createState() => _ConsproddesativadosState();
}

TextStyle lexendExa = TextStyle(
  fontFamily: "LexendExa",
  color: Colors.white,
  fontSize: 60,
);
TextStyle openSans = TextStyle(fontFamily: "Open Sans", color: Colors.white);

var formatador = NumberFormat("#,##0.00", "pt_BR");

TextEditingController exclusaoController = TextEditingController();
TextEditingController pesquisaController = TextEditingController();

TextEditingController idController = TextEditingController();
TextEditingController nomeController = TextEditingController();
TextEditingController categoriaController = TextEditingController();
TextEditingController dataFabController = TextEditingController();
TextEditingController dataValController = TextEditingController();
TextEditingController descController = TextEditingController();
TextEditingController fornecedorController = TextEditingController();
TextEditingController precoController = TextEditingController();
TextEditingController qtdController = TextEditingController();

Produtocontrol produtocontrol = Produtocontrol();
Empresacontrol empresacontrol = Empresacontrol();

class _ConsproddesativadosState extends State<Consproddesativados> {
  GlobalKey<FormState> consultaProdKey = GlobalKey<FormState>();
  GlobalKey<FormState> miniKey = GlobalKey<FormState>();
  GlobalKey<FormState> alteraKey = GlobalKey<FormState>();

  List<Produto> produtos = [];
  List<Produto> produtosFiltrados = [];
  void carregarDados() async {
    List<Produto> lista = [];
    for (var p in await produtocontrol.filtraPorEmpresaLogadaDesativados()) {
      //if (p.empresa.cnpj == Empresa.getCnpjProvisorio) {
      lista.add(p);
      produtosFiltrados.add(p);
      //}
    }
    setState(() {
      produtos = lista;
    });
  }

  void filtrarDados(String pesquisa) /*async*/ {
    List<Produto> lista = [];
    for (var produto
        in /*await produtocontrol.filtraPorEmpresaLogadaDesativados()*/ produtosFiltrados) {
      //if (produto.empresa.cnpj == Empresa.getCnpjProvisorio) {
      if (produto.id.toString().contains(pesquisa) ||
          produto.nome.contains(pesquisa) ||
          produto.fornecedor.contains(pesquisa) ||
          produto.dataValidade.contains(pesquisa) ||
          produto.preco.toString().contains(pesquisa) ||
          produto.qtdEstoque.toString().contains(pesquisa)) {
        lista.add(produto);
      }
      //}
    }
    setState(() {
      produtos = lista;
    });
  }

  void alteraProduto(Produto produto) async {
    if (nomeController.text != "") {
      produto.nome = nomeController.text;
    }
    if (categoriaController.text != "") {
      produto.categoria = categoriaController.text;
    }
    if (dataFabController.text != "") {
      produto.dataFabricacao = dataFabController.text;
    }
    if (dataValController.text != "") {
      produto.dataValidade = dataValController.text;
    }
    if (descController.text != "") {
      produto.descricao = descController.text;
    }
    if (fornecedorController.text != "") {
      produto.fornecedor = fornecedorController.text;
    }
    if (precoController.text != "") {
      produto.preco = double.parse(precoController.text);
    }
    if (qtdController.text != "") {
      produto.qtdEstoque = int.parse(qtdController.text);
    }
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
                  'RFIND - Consultar Produtos',
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
                    MaterialPageRoute(builder: (context) => Produtos()),
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
              key: consultaProdKey,
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
                                  "Validade",
                                  style: openSans.copyWith(color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Preço",
                                  style: openSans.copyWith(color: Colors.white),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Estoque",
                                  style: openSans.copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                            rows: List<DataRow>.generate(
                              produtos.length,
                              (int index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Text(
                                      "${produtos[index].id}",
                                      style: openSans.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      produtos[index].nome,
                                      style: openSans.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      produtos[index].dataValidade,
                                      style: openSans.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "R\$ ${formatador.format(produtos[index].preco)}",
                                      style: openSans.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      "${produtos[index].qtdEstoque}",
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
                            //SizedBox(width: 15),
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
                                          "Reativar produto",
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
                                                          "Digite o ID do produto",
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
                                                      if (miniKey.currentState!
                                                          .validate()) {
                                                        bool produtoElegivel =
                                                            false;
                                                        List<dynamic> temp =
                                                            await produtocontrol
                                                                .filtraPorEmpresaLogadaDesativados();
                                                        if (temp.isNotEmpty) {
                                                          for (var produto
                                                              in temp) {
                                                            if (produto.id ==
                                                                int.parse(
                                                                  exclusaoController
                                                                      .text,
                                                                )) {
                                                              produtoElegivel =
                                                                  true;
                                                              break;
                                                            }
                                                          }
                                                        }
                                                        if (produtoElegivel) {
                                                          await produtocontrol
                                                              .reativar(
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
                                                                      "Produto reativado com sucesso!",
                                                                      style: TextStyle(
                                                                        color:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        exclusaoController
                                                                            .clear();
                                                                        miniKey
                                                                            .currentState!
                                                                            .reset();
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
                                                                      "Não foi encontrado um produto com esse ID!",
                                                                      style: TextStyle(
                                                                        color:
                                                                            Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        exclusaoController
                                                                            .clear();
                                                                        miniKey
                                                                            .currentState!
                                                                            .reset();
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
                                'Reativar produto',
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
