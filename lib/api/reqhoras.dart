import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
Future<void> main() async {
  try {
    final json = await fetch();
    final date = json['date'];
    final time = json['time'];
    //verificador pra ver se o conteudo de date está presente no json.
    print('Data: $date');
    if (time != null) {
      print('Hora: $time');
    }
  } catch (e) {
    print('Erro: $e');
  }
}

Future<Map<String, dynamic>> fetch() async {
  const url = 'http://10.0.0.10:8400/rest/zwstest';
  final response = await http.get(Uri.parse(url));
  final json = jsonDecode(response.body);
  return json;
}
//outros modelos que abaixo.
/*
//usado para testar a conexão.
Future main() async {
  final url = Uri.parse('http://10.0.0.10:8400/rest/zwstest');
  final response = await http.get(url);

  var json = jsonDecode(response.body);

  /*
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print('Falha ao requisitar response');
  }
  */
}
*/
/*
Future<Map> fetch() async {
  final request = Uri.parse("http://10.0.0.10:8400/rest/zwstest");
  http.Response response = await http.get(request);
  return(json.decode(response.body));

}

void main(List<String> args) {
print(fetch());  
}
*/
/*
Future<void> main() async {
  try {
    final json = await fetch();
    if (json.containsKey('date') && json.containsKey('time')) {
      final date = json['date'];
      final time = json['time'];
      print('Data: $date, Hora: $time');
    } else {
      throw Exception('O JSON retornado não contém as chaves "date" e "time"');
    }
  } catch (e) {
    print('Erro: $e');
  }
}

Future<Map<String, dynamic>> fetch() async {
  final url = 'http://10.0.0.10:8400/rest/zwstest';
  final response = await http.get(Uri.parse(url));
  final json = jsonDecode(response.body);
  return json;
}
*/
/*
Future main() async {
  var json = await fetch();
   print(json["date"]);
   print(json["time"] ?? 0); 
}

Future<Map> fetch() async {
  var url = 'http://10.0.0.10:8400/rest/zwstest';
  var response = await http.get(Uri.parse(url));
  var json = jsonDecode(response.body);
  return json;
}
*/