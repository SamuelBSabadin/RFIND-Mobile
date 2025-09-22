import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rfind_mobile/control/empresacontrol.dart';
import 'package:rfind_mobile/control/produtocontrol.dart';
import 'package:rfind_mobile/model/produto.dart';
import 'package:rfind_mobile/view/configs.dart';
import 'package:rfind_mobile/view/perfil.dart';
import 'package:rfind_mobile/view/produtos.dart';

class Consultaprodutos extends StatefulWidget {
  const Consultaprodutos({super.key});

  @override
  State<Consultaprodutos> createState() => _ConsultaprodutosState();
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

class _ConsultaprodutosState extends State<Consultaprodutos> {
  GlobalKey<FormState> consultaProdKey = GlobalKey<FormState>();
  GlobalKey<FormState> miniKey = GlobalKey<FormState>();
  GlobalKey<FormState> alteraKey = GlobalKey<FormState>();

  List<Produto> produtos = [];
  List<Produto> produtosFiltrados = [];
  void carregarDados() async {
    List<Produto> lista = [];
    for (var p in await produtocontrol.filtraPorEmpresaLogadaAtivados()) {
      //if (p.empresa.cnpj == Empresa.getCnpjProvisorio) {
      lista.add(p);
      produtosFiltrados.add(p);
      //}
    }
    setState(() {
      produtos = lista;
    });
  }

  /*Future<void>*/
  void filtrarDados(String pesquisa) /*async*/ {
    List<Produto> lista = [];
    for (var produto
        in /*await produtocontrol.filtraPorEmpresaLogadaAtivados()*/ produtosFiltrados) {
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
                                          "Alterar produto",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        content: SingleChildScrollView(
                                          child: Container(
                                            height: 1004,
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
                                                        "ID do produto",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    validator: (value) {
                                                      try {
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
                                                      } catch (Exception) {
                                                        return "Insira um formato válido!";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: 40),
                                                  TextFormField(
                                                    controller: nomeController,
                                                    decoration: InputDecoration(
                                                      label: Text(
                                                        "Nome do produto",
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
                                                    controller:
                                                        categoriaController,
                                                    decoration: InputDecoration(
                                                      label: Text(
                                                        "Categoria do produto",
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
                                                        return "Categoria não pode conter números!";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: 40),
                                                  TextFormField(
                                                    controller:
                                                        dataFabController,
                                                    onTap: () async {
                                                      DateTime?
                                                      data = await showDatePicker(
                                                        context: context,
                                                        currentDate:
                                                            DateTime.now(),
                                                        firstDate: DateTime(
                                                          1900,
                                                        ),
                                                        lastDate: DateTime(
                                                          2100,
                                                        ),
                                                        builder: (
                                                          context,
                                                          child,
                                                        ) {
                                                          return Theme(
                                                            data: Theme.of(
                                                              context,
                                                            ).copyWith(
                                                              colorScheme: ColorScheme.dark(
                                                                primary: Color(
                                                                  0xff8d1f32,
                                                                ),
                                                                secondary:
                                                                    Color.fromARGB(
                                                                      255,
                                                                      115,
                                                                      115,
                                                                      115,
                                                                    ),
                                                                onSurface:
                                                                    Color.fromARGB(
                                                                      255,
                                                                      115,
                                                                      115,
                                                                      115,
                                                                    ),
                                                              ),
                                                              textButtonTheme:
                                                                  TextButtonThemeData(
                                                                    style: TextButton.styleFrom(
                                                                      foregroundColor:
                                                                          Color(
                                                                            0xff8d1f32,
                                                                          ),
                                                                    ),
                                                                  ),
                                                              /*dialogTheme: DialogTheme(
                                                                backgroundColor:
                                                                    Color(
                                                                      0xff373737,
                                                                    ),
                                                              ),*/
                                                            ),
                                                            child: child!,
                                                          );
                                                        },
                                                      );

                                                      if (data != null) {
                                                        dataFabController
                                                            .text = DateFormat(
                                                          'dd/MM/yyyy',
                                                        ).format(data);
                                                      }
                                                    },
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      label: Text(
                                                        "Data de fabricação",
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
                                                        return null;
                                                      }
                                                      if (dataValController
                                                          .text
                                                          .isEmpty) {
                                                        return null;
                                                      }
                                                      DateTime? data =
                                                          DateFormat(
                                                            'dd/MM/yyyy',
                                                          ).parse(value!);
                                                      if (data.isAfter(
                                                        DateFormat(
                                                          'dd/MM/yyyy',
                                                        ).parse(
                                                          dataValController
                                                              .text,
                                                        ),
                                                      )) {
                                                        return "A data de fabricação deve estar atrás da data de validade!";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: 40),
                                                  TextFormField(
                                                    controller:
                                                        dataValController,
                                                    onTap: () async {
                                                      DateTime?
                                                      data = await showDatePicker(
                                                        context: context,
                                                        currentDate:
                                                            DateTime.now(),
                                                        firstDate: DateTime(
                                                          1600,
                                                        ),
                                                        lastDate: DateTime(
                                                          2100,
                                                        ),
                                                        builder: (
                                                          context,
                                                          child,
                                                        ) {
                                                          return Theme(
                                                            data: Theme.of(
                                                              context,
                                                            ).copyWith(
                                                              colorScheme: ColorScheme.dark(
                                                                primary: Color(
                                                                  0xff8d1f32,
                                                                ),
                                                                secondary:
                                                                    Color.fromARGB(
                                                                      255,
                                                                      115,
                                                                      115,
                                                                      115,
                                                                    ),
                                                                onSurface:
                                                                    Color.fromARGB(
                                                                      255,
                                                                      115,
                                                                      115,
                                                                      115,
                                                                    ),
                                                              ),
                                                              textButtonTheme:
                                                                  TextButtonThemeData(
                                                                    style: TextButton.styleFrom(
                                                                      foregroundColor:
                                                                          Color(
                                                                            0xff8d1f32,
                                                                          ),
                                                                    ),
                                                                  ),
                                                              /*dialogTheme: DialogTheme(
                                                                backgroundColor:
                                                                    Color(
                                                                      0xff373737,
                                                                    ),
                                                              ),*/
                                                            ),
                                                            child: child!,
                                                          );
                                                        },
                                                      );
                                                      if (data != null) {
                                                        dataValController
                                                            .text = DateFormat(
                                                          'dd/MM/yyyy',
                                                        ).format(data);
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                      label: Text(
                                                        "Data de validade",
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
                                                        return null;
                                                      }
                                                      if (dataFabController
                                                          .text
                                                          .isEmpty) {
                                                        return null;
                                                      }
                                                      DateTime? data =
                                                          DateFormat(
                                                            'dd/MM/yyyy',
                                                          ).parseStrict(value!);
                                                      if (data.isBefore(
                                                        DateFormat(
                                                          'dd/MM/yyyy',
                                                        ).parse(
                                                          dataFabController
                                                              .text,
                                                        ),
                                                      )) {
                                                        return "A data de validade deve estar à frente da data de fabricação!";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: 40),
                                                  TextFormField(
                                                    controller: descController,
                                                    decoration: InputDecoration(
                                                      label: Text(
                                                        "Descrição do produto",
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
                                                    controller:
                                                        fornecedorController,
                                                    decoration: InputDecoration(
                                                      label: Text(
                                                        "Fornecedor",
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
                                                    controller: precoController,
                                                    decoration: InputDecoration(
                                                      prefixIcon: Icon(
                                                        Icons.attach_money,
                                                        color: Colors.white,
                                                      ),
                                                      label: Text(
                                                        "Preço",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    validator: (value) {
                                                      try {
                                                        if (value!.isEmpty) {
                                                          return null;
                                                        }
                                                        var temLetra = RegExp(
                                                          r'[A-Za-zÀ-ÿ]',
                                                        );
                                                        if (temLetra.hasMatch(
                                                          value!,
                                                        )) {
                                                          return "O preço não pode conter letras!";
                                                        }
                                                        if (double.parse(
                                                              value,
                                                            ) <=
                                                            0) {
                                                          return "O produto deve ter um preço válido!";
                                                        }
                                                      } catch (Exception) {
                                                        return "Insira um formato válido!";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: 40),
                                                  TextFormField(
                                                    controller: qtdController,
                                                    decoration: InputDecoration(
                                                      label: Text(
                                                        "Quantidade em estoque",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    validator: (value) {
                                                      try {
                                                        if (value!.isEmpty) {
                                                          return null;
                                                        }
                                                        if (int.parse(value!) <
                                                            0) {
                                                          return "A quantidade em estoque deve ser válida!";
                                                        }
                                                      } catch (Exception) {
                                                        return "A quantidade em estoque não pode conter letras!";
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: 40),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      if (alteraKey
                                                          .currentState!
                                                          .validate()) {
                                                        bool produtoElegivel =
                                                            false;
                                                        Produto produto =
                                                            Produto(
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              "",
                                                              0,
                                                              0,
                                                              true,
                                                              Empresa(
                                                                "",
                                                                "",
                                                                "",
                                                              ),
                                                            );
                                                        for (var produtoTemp
                                                            in await produtocontrol
                                                                .filtraPorEmpresaLogadaAtivados()) {
                                                          if (produtoTemp.id ==
                                                              int.parse(
                                                                idController
                                                                    .text,
                                                              )) {
                                                            produto =
                                                                produtoTemp;
                                                            produtoElegivel =
                                                                true;
                                                            break;
                                                          }
                                                        }
                                                        if (produtoElegivel) {
                                                          alteraProduto(
                                                            produto,
                                                          );
                                                          await produtocontrol
                                                              .atualizar(
                                                                produto,
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
                                                                      "Produto alterado com sucesso!",
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
                                                                        categoriaController
                                                                            .clear();
                                                                        dataFabController
                                                                            .clear();
                                                                        dataValController
                                                                            .clear();
                                                                        descController
                                                                            .clear();
                                                                        precoController
                                                                            .clear();
                                                                        fornecedorController
                                                                            .clear();
                                                                        idController
                                                                            .clear();
                                                                        qtdController
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
                                                                      "Não foi encontrado nenhum produto com esse ID!",
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
                                                                        categoriaController
                                                                            .clear();
                                                                        dataFabController
                                                                            .clear();
                                                                        dataValController
                                                                            .clear();
                                                                        descController
                                                                            .clear();
                                                                        precoController
                                                                            .clear();
                                                                        fornecedorController
                                                                            .clear();
                                                                        idController
                                                                            .clear();
                                                                        qtdController
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
                                                      "Alterar produto",
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
                                              idController.clear();
                                              nomeController.clear();
                                              categoriaController.clear();
                                              dataFabController.clear();
                                              dataValController.clear();
                                              descController.clear();
                                              fornecedorController.clear();
                                              precoController.clear();
                                              qtdController.clear();
                                              alteraKey.currentState!.reset();
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
                                'Alterar produto',
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
                                          "Desativar produto",
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
                                                                .filtraPorEmpresaLogadaAtivados();
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
                                                                      "Produto desativado com sucesso!",
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
                                setState(() {
                                  carregarDados();
                                });
                              },
                              child: Text(
                                'Desativar produto',
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
