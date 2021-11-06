import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({this.baseUrl});

  final String baseUrl;

  Future getExchangeRate({String crypto, String fiat}) async {
    String url = baseUrl + crypto + '/' + fiat;

    const apiKey = 'YOUR-API-KEY-HERE';
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        'X-CoinAPI-Key': apiKey,
      },
    );

    if (response.statusCode != 200) {
      print(response.statusCode);
      print(response.body);
      return;
    }

    return jsonDecode(response.body);
  }
}
