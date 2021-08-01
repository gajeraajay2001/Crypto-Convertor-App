import 'package:api_consumer_crypto_converter/services/remote_service.dart';

class Crypto {
  double priceBCH;
  double priceBTC;
  double priceETH;
  double priceXRP;
  Crypto({this.priceBCH, this.priceBTC, this.priceETH, this.priceXRP});

  factory Crypto.fetchCrypto(Map<String, dynamic> json) {
    return Crypto(
      priceBCH: json["data"]["BCH"]["quote"][RemoteService.currency]["price"],
      priceBTC: json["data"]["BTC"]["quote"][RemoteService.currency]["price"],
      priceETH: json["data"]["ETH"]["quote"][RemoteService.currency]["price"],
      priceXRP: json["data"]["XRP"]["quote"][RemoteService.currency]["price"],
    );
  }
}
