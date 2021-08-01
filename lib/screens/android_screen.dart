import 'package:api_consumer_crypto_converter/models/crypto.dart';
import 'package:api_consumer_crypto_converter/services/remote_service.dart';
import 'package:api_consumer_crypto_converter/widgets/crypto_display.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class AndroidScreen extends StatefulWidget {
  @override
  _AndroidScreenState createState() => _AndroidScreenState();
}

class _AndroidScreenState extends State<AndroidScreen> {
  RemoteService remoteService = RemoteService();
  Future<Crypto> fetchCrypto;
  bool switchValue = true;

  @override
  void initState() {
    fetchCrypto = remoteService.fetchCrypto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Switch(
            value: switchValue,
            activeColor: Colors.deepOrange,
            onChanged: (val) {
              setState(() {
                switchValue = val;
                if (switchValue == false) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return MyApp(
                      switchValue: switchValue,
                    );
                  }));
                }
              });
            }),
        title: Text(
          "🤑 Crypto Converter",
          style: TextStyle(fontSize: 20, letterSpacing: 0.8),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("/android");
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
        future: fetchCrypto,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong !!!!!!......."),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: CryptoDataDisplay(
              snapshot: snapshot,
            ),
          );
        },
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 60,
        color: Colors.blue,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Current Currency",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            PopupMenuButton(
              child: Row(
                children: [
                  Text(
                    RemoteService.currency,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  )
                ],
              ),
              onSelected: ((String selected) {
                setState(() {
                  RemoteService.currency = selected.toString();
                  Navigator.of(context).pushReplacementNamed("/android");
                });
              }),
              color: Colors.blue,
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(
                    "INR",
                    style: TextStyle(color: Colors.white),
                  ),
                  value: "INR",
                ),
                PopupMenuItem(
                  child: Text(
                    "AUD",
                    style: TextStyle(color: Colors.white),
                  ),
                  value: "AUD",
                ),
                PopupMenuItem(
                  child: Text(
                    "CAD",
                    style: TextStyle(color: Colors.white),
                  ),
                  value: "CAD",
                ),
                PopupMenuItem(
                  child: Text(
                    "MXN",
                    style: TextStyle(color: Colors.white),
                  ),
                  value: "MXN",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
