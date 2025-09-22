import 'package:flutter/material.dart';
import 'package:rfind_mobile/control/empresacontrol.dart';
import 'package:rfind_mobile/control/funcionariocontrol.dart';
import 'package:rfind_mobile/model/empresa.dart';
import 'package:rfind_mobile/model/funcionario.dart';
import 'package:rfind_mobile/view/funcionarios.dart';

class Cadfunc extends StatefulWidget {
  const Cadfunc({super.key});

  @override
  State<Cadfunc> createState() => _CadfuncState();
}

TextStyle lexendExa = TextStyle(
  fontFamily: "LexendExa",
  color: Colors.white,
  fontSize: 60,
);

Empresacontrol empresacontrol = Empresacontrol();
Funcionariocontrol funcionariocontrol = Funcionariocontrol();

class _CadfuncState extends State<Cadfunc> {
  GlobalKey<FormState> funcKey = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  TextEditingController sobrenomeController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController setorController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  bool cpfExiste = false;
  bool tagExiste = false;
  Future<void> verificaCpf(String cpf) async {
    for (Funcionario funcionario in await funcionariocontrol.listar()) {
      if (cpf == funcionario.cpf) {
        cpfExiste = true;
        break;
      }
    }
  }

  Future<void> verificaTag(String tag) async {
    for (Funcionario f in await funcionariocontrol.listar()) {
      if (f.tagRfid == tag) {
        tagExiste = true;
        break;
      }
    }
  }

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
                  'RFIND - Cadastrar Funcionários',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              /*ListTile(
                onTap: () {
                  nomeController.text = "";
                  sobrenomeController.text = "";
                  cpfController.text = "";
                  setorController.text = "";
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
                  sobrenomeController.text = "";
                  cpfController.text = "";
                  setorController.text = "";
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
                  sobrenomeController.text = "";
                  cpfController.text = "";
                  setorController.text = "";
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Funcionarios()),
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
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            color: Color(0xFF20232A),
            //child: Center(
            child: Form(
              key: funcKey,
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
                                labelText: 'Nome do funcionário',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Preencha o campo nome!";
                                }
                                if (cpfExiste) {
                                  return "Já existe um funcionário com esse CPF!";
                                }
                                var temNumero = RegExp(r'\d');

                                if (temNumero.hasMatch(value)) {
                                  return 'O nome não pode conter números';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 40),
                            TextFormField(
                              controller: sobrenomeController,
                              decoration: InputDecoration(
                                labelText: 'Sobrenome do funcionário',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Preencha o campo sobrenome!";
                                }
                                var temNumero = RegExp(r'\d');

                                if (temNumero.hasMatch(value)) {
                                  return 'O sobrenome não pode conter números!';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 40),
                            TextFormField(
                              controller: cpfController,
                              decoration: InputDecoration(
                                labelText: 'CPF do funcionário',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Preencha o campo CPF!";
                                }
                                if (value.length != 11) {
                                  return "O CPF deve conter 11 caracteres!";
                                }
                                if (cpfExiste) {
                                  return "CPF já existe!";
                                }
                                var temLetra = RegExp(r'[A-Za-zÀ-ÿ]');
                                if (temLetra.hasMatch(value)) {
                                  return "O CPF não pode conter letras!";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 40),
                            TextFormField(
                              controller: setorController,
                              decoration: InputDecoration(
                                labelText: 'Setor do funcionário',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Preencha o campo setor!";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 40),
                            TextFormField(
                              controller: tagController,
                              decoration: InputDecoration(
                                labelText: 'Tag do RFID',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Preencha o campo da Tag do RFID!";
                                }
                                if (tagExiste) {
                                  return "Já há um funcionário com essa tag!";
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
                                await verificaCpf(cpfController.text);
                                await verificaTag(tagController.text);
                                if (cpfExiste) {
                                  setState(() {});
                                }
                                if (tagExiste) {
                                  setState(() {});
                                }
                                if (funcKey.currentState!.validate()) {
                                  Empresa empresa = Empresa("", "", "", "");

                                  for (var empresaTemp
                                      in await empresacontrol.select()) {
                                    if (empresaTemp.cnpj ==
                                        Empresa.getCnpjProvisorio) {
                                      empresa = empresaTemp;
                                      break;
                                    }
                                  }

                                  Funcionario funcionario = Funcionario(
                                    nomeController.text,
                                    sobrenomeController.text,
                                    cpfController.text,
                                    setorController.text,
                                    true,
                                    tagController.text,
                                    empresa,
                                  );

                                  await funcionariocontrol.cadastrar(
                                    funcionario,
                                  );
                                  nomeController.text = "";
                                  sobrenomeController.text = "";
                                  cpfController.text = "";
                                  setorController.text = "";
                                  funcKey.currentState!.reset();
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          "Êxito",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        content: Text(
                                          "Funcionário cadastrado com sucesso!",
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
                                }
                              },
                              child: Text(
                                'Cadastrar funcionário',
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
            //),
          ),
        ),
      ),
    );
  }
}
