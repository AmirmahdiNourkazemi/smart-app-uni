import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/data/model/profile/responseData.dart';
import 'package:smartfunding/utils/success_snack.dart';

Future<void> showCustomBottomSheet(ResponseData r ,BuildContext context) async {
  // Display the bottom sheet.
  showModalBottomSheet(
    showDragHandle: true,
    context: context,
    backgroundColor: AppColorScheme.scafoldCollor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    //isScrollControlled: true, // Use this to make the bottom sheet full-screen
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'دوست عزیز سلام \nمن تجربه سرمایه گذاری در پلتفرم اسمارت فاندینگ را داشتم  با سرمایه گذاری در این پلتفرم میتوانید سود بالا با ضمانت تعهد پرداخت را تجربه کنید روی لینک زیر بزنید تا از فرصت های سرمایه گذاری با سود بالا مطلع شوید 👇👇',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.black),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () async {
                        final uuid = r.user.uuid;
                        final url = 'https://smartfunding.ir/login/$uuid';
                        await Share.share(
                          'دوست عزیز سلام \n من تجربه سرمایه گذاری در پلتفرم اسمارت فاندینگ را داشتم  با سرمایه گذاری در این پلتفرم میتوانید سود بالا با ضمانت تعهد پرداخت را تجربه کنید روی لینک زیر بزنید تا از فرصت های سرمایه گذاری با سود بالا مطلع شوید\n👇👇\n $url',
                        );
                      },
                    child: Text(
                      'اشتراک گذاری',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                   
                       onPressed: () {
                      final uuid = r.user.uuid;
                      final url = 'https://smartfunding.ir/login/$uuid';
                      Clipboard.setData(
                        ClipboardData(
                          text:
                              'دوست عزیز سلام \n من تجربه سرمایه گذاری در پلتفرم اسمارت فاندینگ را داشتم  با سرمایه گذاری در این پلتفرم میتوانید سود بالا با ضمانت تعهد پرداخت را تجربه کنید روی لینک زیر بزنید تا از فرصت های سرمایه گذاری با سود بالا مطلع شوید\n👇👇\n $url',
                        ),
                      );
                      Navigator.of(context).pop();
                    showSuccessSnackBar(context , 'کپی شد');
                    
                    },
                     
                    label: Text(
                      'کپی متن',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
