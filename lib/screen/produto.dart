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
        child: Container(
          color: const Color.fromARGB(255, 30, 22, 185),
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
              Container(
                color: Colors.blue,
                child: Column(children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextField(
                      controller: _codigoController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: 'DIGITE O COD DO PRODUTO',
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.white,
                            width: 3,
                          ))),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _enviarRequisicao,
                    child: const Text('Enviar'),
                  ),
                  //Text('DESCRIÇÃO: ${_descricao?.replaceAll(RegExp(r'[^\x00-\x7F\n\r]+|\n|\r'), ' ') ?? 'Sem descrição'}'),
                  Text('DESCRIÇÃO: ${_descricao ?? 'Sem descrição'}',
                  style: const TextStyle(
                    color: Colors.white
                  ),),
                  /*
                  if (_descricao != null) ...[
                    const SizedBox(height: 16),
                    Text(_descricao),
                  ],
                  */
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
