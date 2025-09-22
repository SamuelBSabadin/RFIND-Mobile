import 'package:flutter/material.dart';
import 'package:rfind_mobile/control/empresacontrol.dart';
import 'package:rfind_mobile/control/localcontrol.dart';
import 'package:rfind_mobile/model/empresa.dart';
import 'package:rfind_mobile/model/local.dart';
import 'package:rfind_mobile/view/configs.dart';
import 'package:rfind_mobile/view/locais.dart';
import 'package:rfind_mobile/view/perfil.dart';

class Cadlocal extends StatefulWidget {
  const Cadlocal({super.key});

  @override
  State<Cadlocal> createState() => _CadlocalState();
}

TextStyle lexendExa = TextStyle(
  fontFamily: "LexendExa",
  color: Colors.white,
  fontSize: 60,
);

Empresacontrol empresacontrol = Empresacontrol();
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

class _CadlocalState extends State<Cadlocal> {
  GlobalKey<FormState> localKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();
  TextEditingController descController = TextEditingController();
  //TextEditingController tagController = TextEditingController();

  List<String> listaDropdown = ["SENSOR1", "SENSOR2", "SENSOR3", "SENSOR4"];
  String dropdownValue = "";

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
                  'RFIND - Cadastrar Local',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              /*ListTile(
                onTap: () {
                  nomeController.text = "";
                  descController.text = "";
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
                  descController.text = "";
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
                  descController.text = "";
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Locais()),
                  );
                },
                leading: Icon(Icons.arrow_back, color: Colors.white),
                title: Text('Voltar', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Color(0xFF20232A),
        child: Center(
          child: Form(
            key: localKey,
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
                              labelStyle: TextStyle(color: Colors.white),
                              labelText: "Nome do local",
                            ),
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Preencha o campo Nome do local!";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 40),
                          TextFormField(
                            controller: descController,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.white),
                              labelText: "Descrição",
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
                          /*TextFormField(
                            controller: tagController,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.white),
                              labelText: "Tag do RFID",
                            ),
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Preencha o campo da tag do RFID!";
                              }
                              if (tagJaUsada == true) {
                                return "Essa tag já está sendo usada!";
                              }
                              return null;
                            },
                          ),*/
                          DropdownButton<String>(
                            value: listaDropdown.first,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            style: TextStyle(color: Colors.white),
                            dropdownColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items:
                                listaDropdown.map<DropdownMenuItem<String>>((
                                  String value,
                                ) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value /*style: TextStyle(color: Colors.black),*/,
                                    ),
                                  );
                                }).toList(),
                          ),
                          SizedBox(height: 40),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(200, 50),
                            ),
                            onPressed: () async {
                              await verificaTag(
                                dropdownValue,
                              ); //await verificaTag(tagController.text);
                              if (tagJaUsada) {
                                setState(() {});
                              }
                              if (localKey.currentState!.validate()) {
                                Empresa empresa = Empresa("", "", "", "");

                                for (var empresatemp
                                    in await empresacontrol.select()) {
                                  if (empresatemp.cnpj ==
                                      Empresa.getCnpjProvisorio) {
                                    empresa = empresatemp;
                                    break;
                                  }
                                }

                                Local local = Local(
                                  nomeController.text,
                                  descController.text,
                                  dropdownValue, //tagController.text,
                                  empresa,
                                );

                                await localcontrol.cadastrar(local);

                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Êxito",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      content: Text(
                                        "Local cadastrado com sucesso!",
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
                                nomeController.text = "";
                                descController.text = "";
                                dropdownValue = ""; //tagController.text = "";
                              }
                            },
                            child: Text(
                              "Cadastrar local",
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
    );
  }
}

/*
  TextFormField(
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          style: TextStyle(color: Colors.white),
                        )
*/
