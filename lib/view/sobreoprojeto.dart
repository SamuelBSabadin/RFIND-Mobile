import 'package:flutter/material.dart';
import 'package:rfind_mobile/view/configs.dart';
import 'package:rfind_mobile/view/menu.dart';
import 'package:rfind_mobile/view/perfil.dart';
import 'package:rfind_mobile/view/quemsomos.dart';

class Sobreoprojeto extends StatefulWidget {
  const Sobreoprojeto({super.key});

  @override
  State<Sobreoprojeto> createState() => _SobreoprojetoState();
}

TextStyle lexendExa = TextStyle(
  fontFamily: "LexendExa",
  color: Colors.white,
  fontSize: 60,
);
TextStyle openSans = TextStyle(fontFamily: "Open Sans", color: Colors.white);

class _SobreoprojetoState extends State<Sobreoprojeto> {
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
                  'RFIND - Sobre o Projeto',
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
                leading: Icon(Icons.people, color: Colors.white),
                title: Text(
                  "Quem somos",
                  style: openSans.copyWith(color: Colors.white),
                ),
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Quemsomos()),
                    ),
              ),
              ListTile(
                leading: Icon(Icons.question_mark, color: Colors.grey),
                title: Text(
                  "Sobre o projeto",
                  style: openSans.copyWith(color: Colors.grey),
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
          //height: 1074,
          //color: Color(0xFF20232A),
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
                  'Sobre o projeto',
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
                          Text(
                            "A RFIND é uma empresa inovadora que utiliza a tecnologia RFID (Identificação por Radiofrequência) para transformar a maneira como empresas gerenciam seus recursos. Nossa missão é proporcionar soluções práticas e eficientes, ajudando nossos clientes a otimizar o rastreamento de produtos e funcionários em tempo real.",
                            style: openSans.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Missão",
                            style: openSans.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Nossa missão é proporcionar soluções de rastreamento precisas e seguras por meio de tecnologia de ponta, melhorando a gestão operacional de empresas em diversos setores. Com a RFIND, você pode aumentar a eficiência dos seus processos e garantir maior controle sobre o seu inventário e equipe.",
                            style: openSans.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Visão",
                            style: openSans.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Ser a principal referência em soluções de rastreamento e gestão de ativos por RFID, ajudando empresas ao redor do mundo a otimizar seus processos e aumentar a segurança e eficiência. Buscamos expandir constantemente nossas soluções para atender cada vez mais a demanda do mercado.",
                            style: openSans.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Benefícios da tecnologia RFID",
                            style: openSans.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Eficiência Operacional: O uso de RFID reduz o tempo gasto com processos manuais, aumentando a velocidade e precisão das operações.\nControle em Tempo Real: Com RFID, é possível rastrear e monitorar produtos e funcionários em tempo real, garantindo maior controle e segurança.\nSegurança Aprimorada: A tecnologia RFID oferece segurança aprimorada, evitando erros humanos e melhorando a rastreabilidade dos ativos.\nRedução de Custos: A implementação do sistema RFID pode reduzir os custos operacionais ao melhorar a eficiência e diminuir perdas.",
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
