import 'package:flutter/material.dart';

void showClipboardSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const AlertDialog(
        alignment: Alignment.bottomCenter,
        actionsAlignment: MainAxisAlignment.center,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "کپی شد",
              style: TextStyle(
                  fontFamily: 'IR',
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
          ],
        ),
      );
    },
  );
  // Close the dialog after 1 second
  Future.delayed(const Duration(seconds: 1), () {
    Navigator.of(context).pop();
  });
}
