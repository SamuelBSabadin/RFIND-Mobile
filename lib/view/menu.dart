import 'package:flutter/material.dart';
import 'package:rfind_mobile/model/empresa.dart';
import 'package:rfind_mobile/view/consultalocais.dart';
import 'package:rfind_mobile/view/funcionarios.dart';
import 'package:rfind_mobile/view/gerenciamentoregistros.dart';
import 'package:rfind_mobile/view/paginicial.dart';
import 'package:rfind_mobile/view/produtos.dart';
import 'package:rfind_mobile/view/quemsomos.dart';
import 'package:rfind_mobile/view/sobreoprojeto.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

final lexendExa = TextStyle(
  fontFamily: "LexendExa",
  color: Colors.white,
  fontSize: 60,
);
TextStyle openSans = TextStyle(fontFamily: "Open Sans", color: Colors.white);

class _MenuState extends State<Menu> {
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
        centerTitle: true,
        toolbarHeight: 100,
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xff20232a),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(17),
                color: Color(0xff20232a),
                child: Text(
                  'RFIND - Menu Principal',
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
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text(
                  'Finalizar sessão',
                  style: openSans.copyWith(color: Colors.white),
                ),
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Paginicial()),
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          //height: MediaQuery.of(context).size.height,
          //color: Color(0xff20232a),
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
                  "Seja bem-vindo(a), ${Empresa.getNomeProvisorio}! O que deseja fazer?",
                  style: openSans.copyWith(fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Funcionarios()),
                    );
                  },
                  icon: Icon(Icons.people_alt, size: 96, color: Colors.white),
                ),
                Text(
                  'Gerenciar funcionários',
                  style: openSans.copyWith(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 30),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Produtos()),
                    );
                  },
                  icon: Icon(
                    Icons.local_grocery_store_rounded,
                    color: Colors.white,
                    size: 96,
                  ),
                ),
                Text(
                  'Gerenciar produtos',
                  style: openSans.copyWith(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 30),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Consultalocais()),
                    );
                  },
                  icon: Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                    size: 96,
                  ),
                ),
                Text(
                  "Gerenciar localizações",
                  style: openSans.copyWith(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 30),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Gerenciamentoregistros(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.report_gmailerrorred,
                    color: Colors.white,
                    size: 96,
                  ),
                ),
                Text(
                  'Gerenciar registros',
                  style: openSans.copyWith(color: Colors.white, fontSize: 18),
                ),

                //Icon(Icons.logout, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
