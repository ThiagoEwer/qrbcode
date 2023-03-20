import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
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

Future main() async {
  var json = await fetch();
  print(json["date"]);
}

Future<Map> fetch() async {
  var url = 'http://10.0.0.10:8400/rest/zwstest';
  var response = await http.get(Uri.parse(url));
  var json = jsonDecode(response.body);
  return json;
}



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