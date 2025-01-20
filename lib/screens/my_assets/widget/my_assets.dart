import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:smartfunding/bloc/get_certificate/certificate_event.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/data/model/profile/transaction.dart';
import 'package:smartfunding/data/model/profile/user.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../bloc/get_certificate/certificate_bloc.dart';
import '../../../bloc/get_certificate/certificate_state.dart';
import '../../../data/model/profile/unit.dart';
import 'factor_dilaog.dart';

class ShowAllAssetsWidget extends StatefulWidget {
  final Unit _unit;
  final User _user;
  const ShowAllAssetsWidget(this._unit, this._user, {super.key});

  @override
  State<ShowAllAssetsWidget> createState() => _ShowAllAssetsWidgetState();
}

class _ShowAllAssetsWidgetState extends State<ShowAllAssetsWidget> {
  bool isPressContainer = false;
  @override
  void initState() {
    BlocProvider.of<CertificateBloc>(context).add(CertificateStartEvent());
  }

  String? certificateUrl;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration:
          const Duration(milliseconds: 300), // Adjust the duration as needed
      curve: Curves.easeInCirc, // Adjust the curve as needed
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black12)),
      width: MediaQuery.of(context).size.width,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isPressContainer = !isPressContainer;
            });
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'تراکنش',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        // Text(
                        //   widget._unit.transactions.length
                        //       .toString()
                        //       .toPersianDigit(),
                        //   style: Theme.of(context).textTheme.headlineSmall,
                        // ),
                      ],
                    ),
                  ),
                  if (widget._unit.title != null) ...{
                    Expanded(
                      flex: 3,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(widget._unit.title!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  overflow: TextOverflow.ellipsis,
                                )),
                      ),
                    )
                  },
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'تومان',
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.black38,
                              fontFamily: 'IR',
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            widget._unit.pivot.amount
                                .toString()
                                .toPersianDigit()
                                .seRagham(),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      Text(
                        'مبلغ سرمایه گذاری',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                    child: Divider(
                      color: Colors.black12,
                    ),
                  ),
                  // if (widget._unit.transactions
                  //     .where((element) => element.type == 3)
                  //     .isNotEmpty) ...{
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           const Text(
                  //             'تومان',
                  //             style: TextStyle(
                  //               fontSize: 8,
                  //               color: Colors.black38,
                  //               fontFamily: 'IR',
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             width: 2,
                  //           ),
                  //           // Text(
                  //           //   widget._unit.transactions
                  //           //       .where((e) => e.type == 3)
                  //           //       .fold(
                  //           //           0,
                  //           //           (sum, e) =>
                  //           //               sum + int.parse(e.amount.toString()))
                  //           //       .toString()
                  //           //       .toPersianDigit()
                  //           //       .seRagham(),
                  //           //   style: Theme.of(context).textTheme.titleSmall,
                  //           // ),
                  //         ],
                  //       ),
                  //       Text(
                  //         'مجموع سود واریزی',
                  //         style: Theme.of(context).textTheme.titleSmall,
                  //       )
                  //     ],
                  //   ),
                  //   const SizedBox(
                  //     height: 25,
                  //     child: Divider(
                  //       color: Colors.black12,
                  //     ),
                  //   ),
                  // },
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget._unit.pivot.createdAt.toPersianDate(),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      Text(
                        'تاریخ خرید اول',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                    child: Divider(
                      color: Colors.black12,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget._unit.pivot.updatedAt.toPersianDate(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        'تاریخ بروزرسانی',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showCustomBottomSheet(
    List<Transaction> trade, BuildContext context) async {
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
      return DraggableScrollableSheet(
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                // height: 250,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: FactorAlertDialoadContainer(trade),
              ));
        },
      );
    },
  );
}
