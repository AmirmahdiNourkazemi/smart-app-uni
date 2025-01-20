import 'package:flutter/material.dart';

void showSuccessSnackBar(BuildContext context, String successMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      closeIconColor: Colors.white,
      content: Text(
        successMessage,
        style: Theme.of(context).textTheme.displaySmall,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
      ),
      backgroundColor: Colors.green,
    ),
  );
}
