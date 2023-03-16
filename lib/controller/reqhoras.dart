import 'package:http/http.dart' as http;

Future<void> main() async {

  final url = Uri.parse('http://10.0.0.10:8400/rest/zwstest');

  final hour = await http.get(url);

  if (hour.statusCode == 200) {
    print(hour.body);
  }
  
}