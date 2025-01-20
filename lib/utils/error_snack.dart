import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String errorMessage) {
  FocusScope.of(context).unfocus();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      closeIconColor: Colors.white,
      behavior: SnackBarBehavior.fixed,
      dismissDirection: DismissDirection.up,
      content: Text(
        errorMessage,
        style: Theme.of(context).textTheme.displaySmall,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
      ),
      backgroundColor: Colors.red,
    ),
  );
}
