// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, avoid_print, unused_import, depend_on_referenced_packages
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:intl/intl.dart';
import 'package:qrbcode/screen/qrbar.dart';
import './model/table.dart';
import './api/reqhoras.dart';
import 'package:meta/meta.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LEITOR QRBAR',
        theme: ThemeData(primaryColor: Colors.blue),
        home: const HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 29, 50, 121),
      /*
      appBar: AppBar(
       // title: Text('Qrbar'),
      ),
      drawer: Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountEmail: Text("thiagoewer@gmail.com"),
            accountName: Text("Thiago Ewerton"),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Meu Perfil"),
            onTap: () {
              Navigator.pop(context);
              //Navegar para outra página
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("Histórico de Leitura"),
            onTap: () {
              Navigator.pop(context);
              //Navegar para outra página
            },
          ),
          ListTile(
            leading: const Icon(Icons.warning_sharp),
            title: const Text("Divergências"),
            onTap: () {
              Navigator.pop(context);
              //Navegar para outra página
            },
          ),
        ],
        ),
      ),*/
      body: Qrbar()
    );
  }
}