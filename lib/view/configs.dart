import 'package:flutter/material.dart';
import 'package:rfind_mobile/view/menu.dart';
import 'package:rfind_mobile/view/perfil.dart';

class Configs extends StatefulWidget {
  const Configs({super.key});

  @override
  State<Configs> createState() => _ConfigsState();
}

class _ConfigsState extends State<Configs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações', style: TextStyle(color: Colors.white)),
        centerTitle: false,
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF20232A),
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
                  'RFIND - Configurações',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.grey),
                title: Text(
                  'Configurações',
                  style: TextStyle(color: Colors.grey),
                ),
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
      body: Container(color: Color(0xFF20232A)),
    );
  }
}
