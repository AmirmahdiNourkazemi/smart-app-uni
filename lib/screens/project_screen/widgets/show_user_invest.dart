import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smartfunding/data/model/investers/use_data.dart';

import '../../../constant/scheme.dart';

class DetailInvester extends StatefulWidget {
  final UserData _userData;
  const DetailInvester(this._userData, {super.key});

  @override
  State<DetailInvester> createState() => _DetailInvesterState();
}

class _DetailInvesterState extends State<DetailInvester> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'سرمایه گذاران',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actionsIconTheme: const IconThemeData(size: 22),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const PhosphorIcon(
                PhosphorIconsBold.arrowRight,
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: AppColorScheme.primaryColor,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/user.png',
                        height: 30,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget._userData.fullName!,
                        style: Theme.of(context).textTheme.labelSmall,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 25,
                        width: 15,
                        decoration: const BoxDecoration(
                          //shape: BoxShape.circle,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          color: AppColorScheme.primaryColor,
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 15,
                        decoration: const BoxDecoration(
                          //shape: BoxShape.circle,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          color: AppColorScheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      'طرح ها',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  SizedBox(
                    height: widget._userData.projects!.length * 100,
                    child: ListView.builder(
                        itemCount: widget._userData.projects!.length,
                        itemBuilder: (context, index) {
                          final isLastIndex =
                              index == widget._userData.projects!.length - 1;
                          return Column(
                            children: [
                              ListTile(
                                leadingAndTrailingTextStyle:
                                    Theme.of(context).textTheme.headlineSmall,
                                titleTextStyle:
                                    Theme.of(context).textTheme.headlineSmall,
                                leading: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: PhosphorIcon(
                                      PhosphorIcons.trendUp(),
                                      color: AppColorScheme.primaryColor,
                                    )),
                                title: Text(
                                    'نام طرح: ${widget._userData.projects![index].title!}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'تاریخ شروع پروژه: ${widget._userData.projects![index].createdAt!.toString().toPersianDate()}',
                                    ),
                                  ],
                                ),
                              ),
                              if (!isLastIndex)
                                Divider(
                                  color: Colors.grey.shade200,
                                )
                            ],
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
