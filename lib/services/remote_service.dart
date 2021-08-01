import 'dart:convert';

import 'package:api_consumer_crypto_converter/models/crypto.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  static String currency = "INR";
  Future<Crypto> fetchCrypto() async {
    http.Response res = await http.get(
      Uri.parse(
          "https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?convert=$currency&symbol=BTC,ETH,XRP,BCH&CMC_PRO_API_KEY=3ddd4fe6-bad5-461d-8cfd-5923ea65143f"),
    );
    if (res.statusCode == 200) {
      return Crypto.fetchCrypto(jsonDecode(res.body));
    } else {
      throw Exception("Something went wrong ....!!!");
    }
  }
}
