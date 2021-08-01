import 'dart:async';
import 'package:api_consumer_crypto_converter/main.dart';
import 'package:api_consumer_crypto_converter/models/crypto.dart';
import 'package:api_consumer_crypto_converter/services/remote_service.dart';
import 'package:api_consumer_crypto_converter/widgets/ios_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IosScreen extends StatefulWidget {
  @override
  _IosScreenState createState() => _IosScreenState();
}

class _IosScreenState extends State<IosScreen> {
  bool switchValue = true;
  RemoteService remoteService = RemoteService();
  Future<Crypto> fetchCrypto;
  bool isLoading = false;
  Timer _timer;
  @override
  void initState() {
    fetchCrypto = remoteService.fetchCrypto();
    super.initState();
  }

  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _timer = new Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
    List currencies = ["INR", "AUD", "CAD", "MXN"];
    List<DropdownMenuItem> getMenuItems() {
      List<DropdownMenuItem> list = [];
      for (String val in currencies) {
        list.add(DropdownMenuItem(
          child: Text(val),
          value: val,
        ));
      }
      return list;
    }

    return (switchValue == false)
        ? MyApp(switchValue: true)
        : Scaffold(
            body: CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  backgroundColor: Colors.blue,
                  leading: CupertinoSwitch(
                    value: switchValue,
                    activeColor: Colors.deepOrange,
                    onChanged: (value) {
                      setState(() {
                        switchValue = value;
                        if (switchValue == false) {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return MyApp(
                              switchValue: true,
                            );
                          }));
                        }
                      });
                    },
                  ),
                  middle: Text(
                    "🤑 Coin Ticker",
                    style: TextStyle(
                        fontSize: 20, color: Colors.white, letterSpacing: 0.8),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (isLoading)
                        ? Center(child: CircularProgressIndicator())
                        : FutureBuilder(
                            future: fetchCrypto,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text("Something went wrong .....!!!"),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return IosDisplay(
                                snapshot: snapshot,
                              );
                            },
                          ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.blue,
                        height: 150,
                        width: double.infinity,
                        child: Center(
                          child: CupertinoPicker(
                              itemExtent: 40,
                              onSelectedItemChanged: (val) {
                                setState(() {
                                  isLoading = true;
                                  RemoteService.currency = currencies[val];
                                });
                              },
                              children: [
                                for (String val in currencies)
                                  Text(
                                    val,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )
                              ]),
                        ),
                      ),
                    ),
                  ],
                )),
          );
  }
}
