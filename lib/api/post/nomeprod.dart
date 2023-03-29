//SÓ PARA ESTUDOS

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchProduto(String codigo) async {
  //retirar os IFs do try(é redundante)
  try {
    final response = await http.post(
      Uri.parse('http://10.0.0.10:8400/rest/zwstest/nomeprod'),
      body: jsonEncode({"codigo": codigo}),
    );
    if (response.statusCode == 201) {
      //  final responseJson = jsonDecode(response.body);
      //DESSA FORMA, Eu transformo o conteudo de response.body que é um texto, em json.
      //  final responseJson = {"product": response.body};
      //DESSA FORMA, O body da resposta é um texto e "resolveu" o problema.
      final responseJson = response.body;
      print(responseJson);
    } else {
      print(response.reasonPhrase);
    }
  } catch (e) {
    print('Erro: $e');
  }
}

/*
Future<void> fetchProduto(String codigo) async {
  final response = await http.post(
    Uri.parse('http://10.0.0.10:8400/rest/zwstest/nomeprod'),
    body: jsonEncode({"codigo": codigo}),
  );

//TESTANDO A COMUTAÇÃO.
  if (response.statusCode == 201) {
    final decodedJson = jsonDecode(response.body);
    print(decodedJson);
  } else {
    //POR ENQUANTO, A RESPOSTA TÁ VINDO COMO ERRO, TEM QUE VERIFICAR O QUE ESTÁ ACONTECENDO NO FONTE
    print(response.reasonPhrase);
  }
}
*/
void main() async {
  // final cod = stdin.readLineSync();
  await fetchProduto("ADC148");
}
