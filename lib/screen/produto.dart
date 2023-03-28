import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Produtos extends StatefulWidget {
  const Produtos({Key key}) : super(key: key);

  @override
  State<Produtos> createState() => _Produtostate();
}

class _Produtostate extends State<Produtos> {
  //controler do imput
  final TextEditingController _codigoController = TextEditingController();
  String _descricao;

  //post do json
  Future<void> _enviarRequisicao() async {
    final String codigo = _codigoController.text;
    final response = await http.post(
      Uri.parse('http://10.0.0.10:8400/rest/zwstest/nomeprod'),
      body: jsonEncode({"codigo": codigo}),
    );

    //get p/ retorno do json
    //verificar se não tiver dando retorno na descrição.
    try {
      //verificar se o retorno do POST é um json ou um TEXTO(mais provável).
      //DESSA FORMA, Eu transformo o conteudo de response.body que é um texto, em json.
      //  final desc= {"product": response.body};
      //DESSA FORMA, O body da response é um texto e "resolveu" o problema, porém ao usar o decode
      final desc = response.body;
      setState(() {
        _descricao = desc;
      });
    } catch (e) {
      print('Erro ao decodificar JSON: $e');

      setState(() {
        _descricao = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
       appBar: AppBar(
        title: const Text('Produtos'),
      ),*/
      body: SingleChildScrollView(
        child: Column(
          children: [
            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Qrbar()),
                      );
                    },
                    child: const Text('VOLTAR'))
                    
              ],
            ),
            */
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height: 120,
                width: 350,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: TextField(
                        controller: _codigoController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            labelText: 'Digite o Código do Produto',
                            labelStyle: TextStyle(color: Colors.white,
                            fontSize: 12),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: _enviarRequisicao,
                          child: const Text('Enviar'),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 500,
                  width: 345,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                              width: 50, child: Icon(Icons.inventory_2)),
                          SizedBox(
                             height: 35,
                              width: 250,
                            child: Text(
                              'PRODUTO: ${_descricao ?? 'Sem descrição'}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
