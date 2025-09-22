import 'package:flutter/material.dart';
import 'package:rfind_mobile/view/consproddesativados.dart';
import 'package:rfind_mobile/view/consultaprodutos.dart';
import 'package:rfind_mobile/view/menu.dart';

class Produtos extends StatefulWidget {
  const Produtos({super.key});

  @override
  State<Produtos> createState() => _ProdutosState();
}

final lexendExa = TextStyle(
  fontFamily: "LexendExa",
  color: Colors.white,
  fontSize: 60,
);
TextStyle openSans = TextStyle(fontFamily: "Open Sans", color: Colors.white);

class _ProdutosState extends State<Produtos> {
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
          color: Color(0xFF20232a),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(17),
                color: Color(0xff20232a),
                child: Text(
                  'RFIND - Gerenciar Produtos',
                  style: openSans.copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
              /*ListTile(
                onTap: () {
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Menu()),
                  );
                },
                leading: Icon(Icons.arrow_back, color: Colors.white),
                title: Text(
                  'Voltar ao menu principal',
                  style: openSans.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    //color: Color(0xFF373737),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(300, 50),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Cadprod(),
                              ),
                            );
                          },
                          child: Text(
                            'Cadastrar Produto',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18 /*fontWeight: FontWeight.bold*/,
                            ),
                          ),
                        ),
                        SizedBox(height: 40),*/
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(300, 50),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Consultaprodutos(),
                              ),
                            );
                          },
                          child: Text(
                            'Consultar Produtos',
                            style: openSans.copyWith(
                              color: Colors.black,
                              fontSize: 18 /*fontWeight: FontWeight.bold*/,
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(300, 50),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Consproddesativados(),
                              ),
                            );
                          },
                          child: Text(
                            'Consultar Desativados',
                            style: openSans.copyWith(
                              color: Colors.black,
                              fontSize: 18 /*fontWeight: FontWeight.bold*/,
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
    );
  }
}
