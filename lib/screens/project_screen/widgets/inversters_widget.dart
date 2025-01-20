import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smartfunding/bloc/projects/project_bloc.dart';
import 'package:smartfunding/bloc/projects/project_event.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/data/model/investers/use_data.dart';
import 'show_user_invest.dart';

Widget buildInvesters(
    BuildContext context,
    Pagination invests,
    double width,
    double height,
    bool isDesktop,
    ScrollController scrollController,
    String uuid) {
  if (invests.data!.isNotEmpty) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                'سرمایه گذاران',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300, // Set the border color
                      width: 1.0, // Set the border width
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          final isLastIndex = index == invests.data!.length - 1;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return DetailInvester(invests.data![index]);
                                  }));
                                },
                                isThreeLine: true,
                                dense: true,
                                titleTextStyle:
                                    Theme.of(context).textTheme.labelSmall,
                                leadingAndTrailingTextStyle:
                                    Theme.of(context).textTheme.labelSmall,
                                title: Text(invests.data![index].fullName!),
                                leading: const Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: PhosphorIcon(
                                    PhosphorIconsLight.userCircle,
                                    color: AppColorScheme.primaryColor,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'تاریخ پیوستن:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    Text(
                                      invests.data![index].createdAt
                                          .toString()
                                          .toPersianDate(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      'تعداد طرح: ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    Text(
                                      invests.data![index].projects!.length
                                          .toString()
                                          .toPersianDigit(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'طرح',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontFamily: 'IR',
                                        color: Colors.grey[700],
                                      ),
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
                        },
                        itemCount: invests.data!.length,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: TextButton.icon(
                                label: Text(
                                  'بعدی',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                          color: invests.nextPageUrl != null
                                              ? AppColorScheme.primaryColor
                                              : Colors.grey),
                                ),
                                onPressed: () {
                                  if (invests.nextPageUrl != null) {
                                    BlocProvider.of<ProjectBloc>(context).add(
                                        ProjectInversterEvent(uuid,
                                            page: invests.currentPage! + 1));
                                  } else {
                                    null;
                                  }
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: invests.nextPageUrl != null
                                      ? AppColorScheme.primaryColor
                                      : Colors.grey,
                                )),
                          ),
                          Text(
                            invests.currentPage.toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton.icon(
                              label: Text(
                                'قبلی',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      color: invests.prevPageUrl != null
                                          ? AppColorScheme.primaryColor
                                          : Colors.grey,
                                    ),
                              ),
                              onPressed: () {
                                if (invests.prevPageUrl != null) {
                                  BlocProvider.of<ProjectBloc>(context).add(
                                      ProjectInversterEvent(uuid,
                                          page: invests.currentPage! - 1));
                                } else {
                                  null;
                                }
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: invests.prevPageUrl != null
                                    ? AppColorScheme.primaryColor
                                    : Colors.grey,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  } else {
    return Container(); // Return an empty container if there are no attachments
  }
}
