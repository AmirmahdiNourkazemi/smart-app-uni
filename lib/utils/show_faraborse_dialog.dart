import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> showFaraborseDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text(
            'لطفا در سامانه سجام ثبت نام کنید',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: RichText(
            text: TextSpan(
              text: 'برای ثبت نام در سامانه روی لینک ',
              style: Theme.of(context).textTheme.titleLarge,
              children: <TextSpan>[
                TextSpan(
                  text: 'کلیک',
                  style: const TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final Uri _url =
                          Uri.parse('https://profilesejam.csdiran.ir/session');

                      await launch('https://profilesejam.csdiran.ir/session');
                    },
                ),
                TextSpan(
                  text: ' کنید',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
