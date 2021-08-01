import 'package:api_consumer_crypto_converter/services/remote_service.dart';
import 'package:api_consumer_crypto_converter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IosDisplay extends StatefulWidget {
  final AsyncSnapshot snapshot;
  IosDisplay({this.snapshot});
  @override
  _IosDisplayState createState() => _IosDisplayState();
}

class _IosDisplayState extends State<IosDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 10),
              getData(
                  title:
                      "1 BCH = ${widget.snapshot.data.priceBCH.toString()} ${RemoteService.currency}"),
              SizedBox(height: 10),
              getData(
                  title:
                      "1 BTC = ${widget.snapshot.data.priceBTC.toString()} ${RemoteService.currency}"),
              SizedBox(height: 10),
              getData(
                  title:
                      "1 ETH = ${widget.snapshot.data.priceETH.toString()} ${RemoteService.currency}"),
              SizedBox(height: 10),
              getData(
                  title:
                      "1 XRP = ${widget.snapshot.data.priceXRP.toString()} ${RemoteService.currency}"),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
