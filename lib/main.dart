// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, avoid_print, unused_import, depend_on_referenced_packages
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import './model/table.dart';
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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String barcode = "";
  String data = "";
  List<Table> tables = [];
  Future<List<Barcode>> barcodes;

//para puxar todos os códigos na tabela.
  @override
  void initState() {
    super.initState();
    barcodes = Barcode.getAllBarcodes();
  }

  Future scan() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() {
        barcode = result.rawContent;
        data = result.format.toString();
        tables.add(Table());
      });
    } catch (e) {
      Future.error(
          "Ocorreu um erro ao escanear o código de barras"); //   print(e);
    }
  }

  void _limpar() {
    setState(() {
      barcode = "";
      data = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 50, 121),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(7)),
            Column(
              children: [
                Container(
                  width: 350,
                  height: 140,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 29, 50, 121),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.all(5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              ElevatedButton(
                                onPressed: null,
                                child: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                  child: Text(
                                'Home Page',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )),
                            ],
                          ), //COLOCAR BOTÃO
                          Padding(
                            padding: const EdgeInsets.only(left: 138, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                ElevatedButton(
                                    onPressed: null,
                                    child: Icon(
                                      Icons.exit_to_app,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
//LUGAR ONDE VAI O PRIMEIRO GET DO PROJETO

                              SizedBox(
                                  child: Text(
                                '  02, Fev, 2023',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                child: Icon(
                                  Icons.flutter_dash,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              const SizedBox(
                                  child: Text(
                                'Expedidor',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                              Padding(
                                padding: const EdgeInsets.only(left: 77),
                                child: SizedBox(
                                  height: 35,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        await Barcode.deleteAllBarcodes();
                                      },
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.sync,
                                          ),
                                          Text("Sync"),
                                          SizedBox(
                                            width: 8,
                                            height: 58,
                                          ),
                                        ],
                                      )),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 356,
                    height: 540,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 118, 147, 243),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  onPressed: scan,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[
                                      Icon(Icons.qr_code),
                                      SizedBox(
                                        width: 8,
                                        height: 58,
                                      ),
                                      Text("SCAN"),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      Barcode b = Barcode(
                                          id: 0, code: barcode, data: data);
                                      await b.saveBarcode();
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(Icons.save),
                                        SizedBox(
                                          width: 8,
                                          height: 58,
                                        ),
                                        Text("Salvar"),
                                      ],
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: _limpar,
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.clear,
                                      ),
                                      Text("Limpar"),
                                      SizedBox(
                                        width: 5,
                                        height: 58,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 330,
                          height: 120,
                          decoration: const BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 80,
                                child: Center(
                                  child: Text(
                                    "COD BARRA: $barcode",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 40,
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text("FORMATO: $data",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 330,
                            height: 300,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: FutureBuilder<List<Barcode>>(
                                future: Barcode.getAllBarcodes(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.separated(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          leading: const Icon(Icons.qr_code_2),
                                          title: Text(
                                            snapshot.data[index].code,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                              snapshot.data[index].data,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          trailing: const Icon(Icons.more_vert),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const Divider();
                                      },
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  return const CircularProgressIndicator();
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
