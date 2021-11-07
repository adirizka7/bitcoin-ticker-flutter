import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData({String crypto, String fiat}) async {
    String url =
        'https://rest.coinapi.io/v1/exchangerate/' + crypto + '/' + fiat;

    const apiKey = 'YOUR-API-KEY-HERE';
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'X-CoinAPI-Key': apiKey,
        },
      ); // http.get

      if (response.statusCode != 200) {
        print(response.statusCode);
        print(response.body);
        return;
      }

      var body = jsonDecode(response.body);
      return body['rate'];
    } catch (e) {
      print(e);
    }
  }
}
