import 'package:flutter/material.dart';
import 'package:rfind_mobile/model/empresa.dart';
import 'package:rfind_mobile/view/configs.dart';
import 'package:rfind_mobile/view/menu.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

AssetImage imgPrf = AssetImage("assets/images/perfilgenerico.png");
Text txtNome = Text(
  Empresa.getNomeProvisorio,
  style: TextStyle(color: Colors.white, fontSize: 25),
);

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha empresa', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF20232A),
        foregroundColor: Colors.white,
        toolbarHeight: 60,
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
                  'RFIND - Minha empresa',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              ListTile(
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
                leading: Icon(Icons.apartment, color: Colors.grey),
                title: Text(
                  'Minha empresa',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ListTile(
                leading: Icon(Icons.arrow_back, color: Colors.white),
                title: Text(
                  'Voltar ao menu principal',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Menu()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Color(0xFF20232A),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(backgroundImage: imgPrf, radius: 115),
              SizedBox(height: 10),
              txtNome,
            ],
          ),
        ),
      ),
    );
  }
}
