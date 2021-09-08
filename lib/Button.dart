import 'package:flutter/material.dart';

Widget buttonblue(BuildContext context, String label) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 13),
    decoration: BoxDecoration(
      color: Color.fromRGBO(255, 255, 255, 0.9),
      borderRadius: BorderRadius.circular(30),
    ),
    height: 50,
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width - 48,
    child: Text(
      label,
      style: TextStyle(color: Colors.black87, fontSize: 21, fontWeight: FontWeight.w600),
    ),
  );
}