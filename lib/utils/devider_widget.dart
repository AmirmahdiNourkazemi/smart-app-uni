import 'package:flutter/material.dart';

Widget deviderWidget() {
  return const SizedBox(
    height: 25,
    child: Divider(
      color: Colors.black12,
    ),
  );
}


Widget deviderSmallWidget(double width) {
  return  SizedBox(
    width:width ,
    height: 10,
    child: const Divider(
      color: Colors.black12,
    ),
  );
}
