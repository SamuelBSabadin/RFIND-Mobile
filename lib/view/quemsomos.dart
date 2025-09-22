import 'package:flutter/material.dart';
import 'package:rfind_mobile/view/configs.dart';
import 'package:rfind_mobile/view/menu.dart';
import 'package:rfind_mobile/view/perfil.dart';
import 'package:rfind_mobile/view/sobreoprojeto.dart';

class Quemsomos extends StatefulWidget {
  const Quemsomos({super.key});

  @override
  State<Quemsomos> createState() => _QuemsomosState();
}

TextStyle lexendExa = TextStyle(
  fontFamily: "LexendExa",
  color: Colors.white,
  fontSize: 60,
);
TextStyle openSans = TextStyle(fontFamily: "Open Sans", color: Colors.white);

class _QuemsomosState extends State<Quemsomos> {
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
      drawer: Drawer(
        child: Container(
          color: Color(0xFF20232a),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(17),
                color: Color(0xff20232a),
                child: Text(
                  'RFIND - Quem Somos',
                  style: openSans.copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
              /*ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text(
                  'Configurações',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Configs()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.apartment, color: Colors.white),
                title: Text(
                  'Minha Empresa',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Perfil()),
                  );
                },
              ),*/
              ListTile(
                leading: Icon(Icons.people, color: Colors.grey),
                title: Text(
                  "Quem somos",
                  style: openSans.copyWith(color: Colors.grey),
                ),
              ),
              ListTile(
                leading: Icon(Icons.question_mark, color: Colors.white),
                title: Text(
                  "Sobre o projeto",
                  style: openSans.copyWith(color: Colors.white),
                ),
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Sobreoprojeto()),
                    ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Menu()),
                  );
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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          //height: 1827,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Color(0xff2C2D38)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Conheça nossa equipe',
                  style: openSans.copyWith(color: Colors.white, fontSize: 40),
                  textAlign: TextAlign.center,
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
                          Text(
                            "Somos estudantes do Colégio Técnico de Limeira (COTIL) e atualmente estamos cursando o terceiro ano do curso de desenvolvimento de sistemas. Os membros que compõem nossa equipe são:",
                            style: openSans.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Image.asset(
                            "assets/images/kaua.jpeg",
                            width: 300,
                            height: 300,
                          ),
                          Text(
                            "Kauã Oliveira, Analista de Qualidade/Back-End Developer/Administrador de Banco de Dados/Arquiteto de Sistemas",
                            style: openSans.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Image.asset(
                            "assets/images/luis.jpeg",
                            width: 300,
                            height: 300,
                          ),
                          Text(
                            "Luis Felipe de Freitas, Gerente de Projeto/Front-End Developer/Analista de Requisitos/Scrum Master",
                            style: openSans.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Image.asset(
                            "assets/images/renato.png",
                            width: 300,
                            height: 300,
                          ),
                          Text(
                            "Renato Moreira da Silva, Designer de Experiência de Uso/Front-End Developer/Analista de Suporte",
                            style: openSans.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Image.asset(
                            "assets/images/samuel.png",
                            width: 300,
                            height: 300,
                          ),
                          Text(
                            "Samuel Bortoloti Sabadin, Back-End Developer/Administrador de Banco de Dados/Arquiteto de Sistemas ",
                            style: openSans.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
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
