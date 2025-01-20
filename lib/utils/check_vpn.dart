import 'package:flutter/material.dart';

Future<void> checkVpnStatus(BuildContext context) async {
  // bool isVpnActive = await VpnConnectionDetector.isVpnActive();
  // if (isVpnActive) {
  //   _showVpnSnackBar(context);
  // }
}

void _showVpnSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.up,
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.red,
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: Text(
                'تنظیمات',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              )),
          Text(
            'لطفا فیلترشکن خود را خاموش کنید',
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
