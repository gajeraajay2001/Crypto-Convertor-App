import 'package:flutter/material.dart';

Container getData({
  String title,
}) {
  return Container(
    alignment: Alignment.center,
    height: 55,
    width: 330,
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      title,
      style: TextStyle(color: Colors.white, fontSize: 20),
    ),
  );
}
