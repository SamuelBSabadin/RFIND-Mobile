import 'package:flutter/material.dart';
import 'package:rfind_mobile/view/paginicial.dart';
//import 'dart:io';
/*Future<void> startApiSpringBoot() async {
  final scriptDir = Directory.current.path;
  final apiPath = '$scriptDir/../api_rfind';
    final mvnCommand = Platform.isWindows ? 'mvnw.cmd' : './mvnw';

  final process = await Process.start(
    mvnCommand,
    ['spring-boot:run'],
    workingDirectory: apiPath,
    mode: ProcessStartMode.detached,
    runInShell: true,
  );

  print('API Spring Boot iniciada com PID ${process.pid}');
}*/

void main() async {
  //await startApiSpringBoot();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RFIND',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Paginicial(),
    );
  }
}
