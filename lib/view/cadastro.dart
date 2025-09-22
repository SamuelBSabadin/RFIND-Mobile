import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rfind_mobile/control/empresacontrol.dart';
import 'package:rfind_mobile/model/empresa.dart';
import 'package:rfind_mobile/view/paginicial.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

TextStyle lexendExa = TextStyle(
  fontFamily: "LexendExa",
  color: Colors.white,
  fontSize: 60,
);
TextStyle openSans = TextStyle(fontFamily: "Open Sans", color: Colors.white);
double sizeErro = 0; //quando não tiver informação certa vira 15

String infoErro = '';

Empresacontrol empresacontrol = Empresacontrol();

bool empresaJaExiste = false;

Future<void> verificaEmpresa(String cnpj) async {
  for (Empresa empresa in await empresacontrol.select()) {
    if (empresa.cnpj == cnpj) {
      empresaJaExiste = true;
      break;
    }
  }
}

Empresacontrol _empresacontrol = Empresacontrol();

class _CadastroState extends State<Cadastro> {
  final cnpjFormatter = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  GlobalKey<FormState> userKey2 = GlobalKey<FormState>();
  TextEditingController txtCnpjController = TextEditingController();
  TextEditingController txtEmailController = TextEditingController();
  TextEditingController txtNomeEmpresaController = TextEditingController();
  TextEditingController textSenhaController = TextEditingController();
  TextEditingController txtConfirmarSenhaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
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
        toolbarHeight: 100,
        centerTitle: true,
      ),
      body: Container(
        //color: Color(0xFF20232A),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xff2C2D38)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        //height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Form(
            key: userKey2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cadastrar-se',
                  style: openSans.copyWith(color: Colors.white, fontSize: 40),
                ),
                SizedBox(height: 60),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      //color: const Color(0XFF373737),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: txtCnpjController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [cnpjFormatter],
                            decoration: InputDecoration(
                              labelText: 'CNPJ',
                              labelStyle: openSans.copyWith(
                                color: Colors.white,
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 194, 35, 24),
                                ),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 194, 35, 24),
                                  width: 2,
                                ),
                              ),
                            ),
                            style: openSans.copyWith(color: Colors.white),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Preencha o campo CNPJ!";
                              }
                              if (value.length < 18 || value.length > 18) {
                                return "O CNPJ deve conter 14 caracteres!";
                              }
                              if (empresaJaExiste) {
                                return "Já existe uma empresa com esse CNPJ!";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: sizeErro),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              infoErro,
                              style: openSans.copyWith(
                                color: const Color.fromARGB(255, 194, 35, 24),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          TextFormField(
                            controller: txtEmailController,
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              labelStyle: openSans.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            style: openSans.copyWith(color: Colors.white),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Preencha o campo e-mail!";
                              }
                              final emailRegex = RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              );
                              if (!emailRegex.hasMatch(value)) {
                                return "Digite um e-mail válido!";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 40),
                          TextFormField(
                            controller: txtNomeEmpresaController,
                            decoration: InputDecoration(
                              labelText: 'Nome da empresa',
                              labelStyle: openSans.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            style: openSans.copyWith(color: Colors.white),
                            validator: (value) {
                              if (value!.length < 3) {
                                return "O nome da empresa deve ter 3 ou mais caracteres!";
                              } else if (value.isEmpty) {
                                return "Preencha o campo Nome da empresa!";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 40),
                          TextFormField(
                            obscureText: true,
                            controller: textSenhaController,
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              labelStyle: openSans.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            style: openSans.copyWith(color: Colors.white),
                            validator: (value) {
                              if (value!.length < 8) {
                                return "A senha deve ter 8 caracteres ou mais!";
                              } else if (value.contains(" ") ||
                                  value.contains(".") ||
                                  value.contains("!") ||
                                  value.contains(",") ||
                                  value.contains(";")) {
                                return "a senha não pode conter espaços ou símbolos!";
                              } else if (value.isEmpty) {
                                return "a senha não pode ser vazia!";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 40),
                          TextFormField(
                            obscureText: true,
                            controller: txtConfirmarSenhaController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Confirmar senha',
                              labelStyle: openSans.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            style: openSans.copyWith(color: Colors.white),
                            validator: (value) {
                              if (value! != textSenhaController.text) {
                                return "As senhas devem ser iguais!";
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
                              empresaJaExiste = false;
                              await verificaEmpresa(txtCnpjController.text);
                              if (userKey2.currentState!.validate()) {
                                String cnpj = txtCnpjController.text.replaceAll(
                                  RegExp(r'[^0-9]'),
                                  "",
                                );
                                Empresa empresa = Empresa(
                                  cnpj,
                                  txtEmailController.text,
                                  txtNomeEmpresaController.text,
                                  textSenhaController.text,
                                );
                                await _empresacontrol.cadastrar(empresa);
                                txtCnpjController.text = "";
                                txtEmailController.text = "";
                                txtNomeEmpresaController.text = "";
                                textSenhaController.text = "";
                                txtConfirmarSenhaController.text = "";
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => AlertDialog(
                                        backgroundColor: Color(0xff373737),
                                        title: Text(
                                          "Êxito",
                                          style: openSans.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                        content: Text(
                                          "Cadastro feito com sucesso: $cnpj\n${empresa.email}",
                                          style: openSans.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) => Paginicial(),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Voltar",
                                              style: openSans.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                );
                              }
                            },
                            child: Text(
                              'Cadastrar-se',
                              style: openSans.copyWith(
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
