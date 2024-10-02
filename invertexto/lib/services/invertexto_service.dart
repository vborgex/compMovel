import 'dart:convert';
import 'package:http/http.dart' as http;

final String _token = "15478|vfAkTpxElVHZkRM6TBzDiAPNfD2HEHNr";

Future<Map> converterNumeroPorExtenso(String? _valor) async{
  http.Response response;
  response = await http.get(Uri.parse(("https://api.invertexto.com/v1/number-to-words?token=$_token&number=$_valor&language=pt&currency=BRL")));
  return json.decode(response.body);
}


Future<Map> buscaCep(String? _valor) async{
  http.Response response;
  response = await http.get(Uri.parse(("https://api.invertexto.com/v1/cep/$_valor?token=$_token")));
  return json.decode(response.body);
}

Future<Map> localizarIP(String? _valor) async{
  http.Response response;
  response = await http.get(Uri.parse(("https://api.invertexto.com/v1/geoip/$_valor?token=$_token")));
  return json.decode(response.body);
}