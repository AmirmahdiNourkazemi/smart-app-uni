import 'package:flutter/material.dart';

Widget disableContainer(BuildContext context, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey.shade200,
    ),
    child: Text(
      text,
      style: Theme.of(context).textTheme.titleSmall,
    ),
  );
}
