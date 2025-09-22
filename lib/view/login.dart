import 'package:flutter/material.dart';
import 'package:rfind_mobile/control/empresacontrol.dart';
import 'package:rfind_mobile/model/empresa.dart';
import 'package:rfind_mobile/view/menu.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

TextStyle lexendExa = TextStyle(
  fontFamily: "LexendExa",
  color: Colors.white,
  fontSize: 60,
);
TextStyle openSans = TextStyle(fontFamily: "Open Sans", color: Colors.white);
double sizeErro = 0; //quando não tiver informação certa vira 15
String infoErro = "";

bool empresaEncontrada = false;

Empresacontrol empresacontrol = Empresacontrol();

class _LoginState extends State<Login> {
  TextEditingController txtEmailController = TextEditingController();
  TextEditingController textSenhaController = TextEditingController();

  GlobalKey<FormState> userKey = GlobalKey<FormState>();

  Future<bool> buscaEmpresa() async {
    bool empresaEncontrada = false;
    List<dynamic> listaTemp = await empresacontrol.select();
    for (Empresa e in listaTemp) {
      if (e.email == txtEmailController.text &&
          e.senha == textSenhaController.text) {
        empresaEncontrada = true;
        break;
      }
    }
    return empresaEncontrada;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        backgroundColor: Colors.black,
        foregroundColor: Colors.white, //temporário até o style
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
        child: Form(
          key: userKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Iniciar sessão',
                  style: openSans.copyWith(color: Colors.white, fontSize: 40),
                ),
                SizedBox(height: 60),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      //color: Color(0XFF373737),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                              /*if (value!.isEmpty) {
                                return "Preencha o campo CNPJ";
                              }*/

                              if (!empresaEncontrada) {
                                return "Empresa não encontrada";
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
                              /*if (value!.isEmpty) {
                                return "Preencha o campo senha";
                              }*/
                              return null;
                            },
                          ),
                          SizedBox(height: sizeErro),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              infoErro,
                              style: openSans.copyWith(
                                color: Color.fromARGB(255, 194, 35, 24),
                              ),
                            ), //Um ou mais campos não estão preenchidos corretamente!
                          ),
                          SizedBox(height: 40),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(200, 50),
                            ),
                            onPressed: () async {
                              Empresa.emailProvisorio = txtEmailController.text;

                              for (Empresa empresa
                                  in await empresacontrol.select()) {
                                if (empresa.email ==
                                    Empresa.getEmailProvisorio) {
                                  Empresa.cnpjProvisorio = empresa.cnpj;
                                  Empresa.nomeProvisorio = empresa.nome;
                                  Empresa.senhaProvisoria = empresa.senha;
                                  break;
                                }
                              }
                              empresaEncontrada = await buscaEmpresa();
                              if (!empresaEncontrada) {
                                setState(() {
                                  /*sizeErro = 15;
                                    infoErro = "Empresa não encontrada";*/
                                });
                              }

                              if (userKey.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Menu(),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Iniciar sessão',
                              style: openSans.copyWith(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),

                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(onPressed: (){}, icon: Icon(Icons.question_mark,color: Colors.white,),iconSize: 15,),
                              //SizedBox(width: 5,),
                              Text("Esqueci minha senha",style: TextStyle(color: Colors.white,fontSize: 15),)
                            ],
                          )*/
                          /*Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(5),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.question_mark,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Esqueci minha senha",
                                      style: openSans.copyWith(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),*/
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

 */
