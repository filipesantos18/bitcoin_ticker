import 'dart:convert';

import 'package:http/http.dart' as http;

const coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'BB6F1FAE-AC6B-415C-9087-E28007017FB3';

class CoinData {
  Future<dynamic> getCoinData(String currency) async {
    var cryptoPrices = <String, String>{};
    for (String crypto in cryptoList) {
      Uri url = Uri.parse('$coinApiUrl/$crypto/$currency?apikey=$apiKey');
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];

        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);

        throw 'There was a problem with the request';
      }
    }
    return cryptoPrices;
  }
}

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
