import 'package:flutter/material.dart';
import 'package:rfind_mobile/control/empresacontrol.dart';
import 'package:rfind_mobile/control/produtocontrol.dart';
import 'package:rfind_mobile/model/empresa.dart';
import 'package:rfind_mobile/model/produto.dart';
import 'package:intl/intl.dart';
import 'package:rfind_mobile/view/produtos.dart';

class Cadprod extends StatefulWidget {
  const Cadprod({super.key});

  @override
  State<Cadprod> createState() => _CadprodState();
}

TextStyle lexendExa = TextStyle(
  fontFamily: "LexendExa",
  color: Colors.white,
  fontSize: 60,
);

Empresacontrol _empresacontrol = Empresacontrol();
Produtocontrol _produtocontrol = Produtocontrol();

class _CadprodState extends State<Cadprod> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController categoriaController = TextEditingController();
  TextEditingController datafabController = TextEditingController();
  TextEditingController datavalController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController fornecedorController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController qtdController = TextEditingController();

  GlobalKey<FormState> prodKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF20232A),
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
          color: Color(0xFF373737),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(17),
                color: Color(0xff373737),
                child: Text(
                  'RFIND - Cadastrar produto',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              /*ListTile(
                onTap: () {
                  nomeController.text = "";
                  categoriaController.text = "";
                  datafabController.text = "";
                  datavalController.text = "";
                  descController.text = "";
                  fornecedorController.text = "";
                  precoController.text = "";
                  qtdController.text = "";
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
                  nomeController.text = "";
                  categoriaController.text = "";
                  datafabController.text = "";
                  datavalController.text = "";
                  descController.text = "";
                  fornecedorController.text = "";
                  precoController.text = "";
                  qtdController.text = "";
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
                  nomeController.text = "";
                  categoriaController.text = "";
                  datafabController.text = "";
                  datavalController.text = "";
                  descController.text = "";
                  fornecedorController.text = "";
                  precoController.text = "";
                  qtdController.text = "";
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Produtos()),
                  );
                },
                leading: Icon(Icons.arrow_back, color: Colors.white),
                title: Text('Voltar', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFF20232A),
          child: Center(
            child: Form(
              key: prodKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(0xFF373737),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 40,
                          horizontal: 40,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: nomeController,
                              decoration: InputDecoration(
                                labelText: 'Nome do produto',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Preencha o campo Nome do produto!";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 40),
                            TextFormField(
                              controller: categoriaController,
                              decoration: InputDecoration(
                                labelText: 'Categoria',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Preencha o campo Categoria!";
                                }
                                var temNumero = RegExp(r'\d');
                                if (temNumero.hasMatch(value)) {
                                  return "Categoria não pode conter números!";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 40),
                            TextFormField(
                              controller: datafabController,
                              onTap: () async {
                                DateTime? data = await showDatePicker(
                                  context: context,
                                  currentDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.dark(
                                          primary: Color(0xff8d1f32),
                                          secondary: Color.fromARGB(
                                            255,
                                            115,
                                            115,
                                            115,
                                          ),
                                          onSurface: Color.fromARGB(
                                            255,
                                            115,
                                            115,
                                            115,
                                          ),
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Color(0xff8d1f32),
                                          ),
                                        ),
                                        /*dialogTheme: DialogTheme(
                                          backgroundColor: Color(0xff373737),
                                        ),*/
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (data != null) {
                                  datafabController.text = DateFormat(
                                    'dd/MM/yyyy',
                                  ).format(data);
                                }
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Data de fabricação',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Preencha o campo Data de fabricação!";
                                }
                                if (datavalController.text.isEmpty) {
                                  return "Data de validade não preenchida!";
                                }
                                DateTime data = DateFormat(
                                  'dd/MM/yyyy',
                                ).parse(value);
                                if (data.isAfter(
                                  DateFormat(
                                    'dd/MM/yyyy',
                                  ).parse(datavalController.text),
                                )) {
                                  return "A data de fabricação deve estar atrás da data de validade!";
                                }
                                if (data.isAfter(DateTime.now())) {
                                  return "Insira uma data válida!";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 40),
                            TextFormField(
                              controller: datavalController,
                              onTap: () async {
                                DateTime? data = await showDatePicker(
                                  context: context,
                                  currentDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.dark(
                                          primary: Color(0xff8d1f32),
                                          secondary: Color.fromARGB(
                                            255,
                                            115,
                                            115,
                                            115,
                                          ),
                                          onSurface: Color.fromARGB(
                                            255,
                                            115,
                                            115,
                                            115,
                                          ),
                                        ),
                                        /*dialogTheme: DialogTheme(
                                          backgroundColor: Color(0xff373737),
                                        ),*/
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Color(0xff8d1f32),
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (data != null) {
                                  datavalController.text = DateFormat(
                                    'dd/MM/yyyy',
                                  ).format(data);
                                }
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Data de validade',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Preencha o campo Data de validade!";
                                }
                                if (datafabController.text.isEmpty) {
                                  return "Data de fabricação não preenchida!";
                                }
                                DateTime data = DateFormat(
                                  'dd/MM/yyyy',
                                ).parse(value);
                                if (data.isBefore(
                                  DateFormat(
                                    'dd/MM/yyyy',
                                  ).parse(datafabController.text),
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
                                labelText: 'Descrição',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Preencha o campo Descrição!";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 40),
                            TextFormField(
                              controller: fornecedorController,
                              decoration: InputDecoration(
                                labelText: 'Fornecedor',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Preencha o campo Fornecedor!";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 40),
                            TextFormField(
                              controller: precoController,
                              decoration: InputDecoration(
                                labelText: 'Preço',
                                labelStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(
                                  Icons.attach_money,
                                  color: Colors.white,
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Preencha o campo Preço";
                                }
                                var temLetra = RegExp(r'[A-Za-zÀ-ÿ]');
                                if (temLetra.hasMatch(value)) {
                                  return "O preço não pode conter letras!";
                                }
                                if (double.parse(value) <= 0) {
                                  return "O produto deve ter um preço válido!";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 40),
                            TextFormField(
                              controller: qtdController,
                              decoration: InputDecoration(
                                labelText: 'Quantidade em estoque',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                try {
                                  if (value!.isEmpty) {
                                    return "Preencha o campo Quantidade em estoque!";
                                  }
                                  if (int.parse(value) < 0) {
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
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(200, 50),
                              ),
                              onPressed: () async {
                                if (prodKey.currentState!.validate()) {
                                  Empresa empresa = Empresa("", "", "", "");

                                  for (var empresaTemp
                                      in await _empresacontrol.select()) {
                                    if (empresaTemp.cnpj ==
                                        Empresa.getCnpjProvisorio) {
                                      empresa = empresaTemp;
                                      break;
                                    }
                                  }

                                  Produto produto = Produto(
                                    nomeController.text,
                                    categoriaController.text,
                                    datafabController.text,
                                    datavalController.text,
                                    descController.text,
                                    fornecedorController.text,
                                    double.parse(
                                      precoController.text.replaceAll(',', '.'),
                                    ),
                                    int.parse(qtdController.text),
                                    true,
                                    empresa,
                                  );

                                  await _produtocontrol.cadastrar(produto);
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          "Êxito",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        content: Text(
                                          "Produto cadastrado com sucesso!",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Color(0xFF373737),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
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
                                      );
                                    },
                                  );
                                  nomeController.clear();
                                  categoriaController.clear();
                                  datafabController.clear();
                                  datavalController.clear();
                                  descController.clear();
                                  fornecedorController.clear();
                                  precoController.clear();
                                  qtdController.clear();
                                }
                              },
                              child: Text(
                                'Cadastrar produto',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
