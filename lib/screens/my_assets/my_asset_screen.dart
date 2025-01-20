import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/get_certificate/certificate_bloc.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_event.dart';
import '../../bloc/profile/profile_state.dart';
import '../../constant/scheme.dart';
import 'widget/empty_screen.dart';
import 'widget/my_assets.dart';

class MyAssets extends StatefulWidget {
  const MyAssets({super.key});

  @override
  State<MyAssets> createState() => _MyAssetsState();
}

class _MyAssetsState extends State<MyAssets> {
  void initState() {
    // TODO: implement initState
    BlocProvider.of<ProfileBloc>(context).add(ProfileStartEvent());
  }

  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return ListView(
            controller: _controller,
            shrinkWrap: true,
            children: [
              if (state is ProfileLoadingState) ...{
                Shimmer.fromColors(
                  period: const Duration(milliseconds: 500),
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.white,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: Container(
                              height: 170,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(right: 20, top: 20),
                            child: Container(
                              height: 170,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                          ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child: Text(
                              'سرمایه گذاری ها',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      for (int i = 0; i < 3; i++) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300),
                          ),
                        )
                      ]
                    ],
                  ),
                )
              } else if (state is ProfileResponseState) ...{
                state.getProfile.fold(
                  (l) => Text(l),
                  (r) {
                    if (r.units!.isEmpty) {
                      // print(r.units);
                      return const EmptyAssets();
                    } else {
                      num totalAmountType1 = 0;
                      r.units!.forEach((unit) {
                        // unit.pivot.forEach((transaction) {
                        //   if (transaction.type == 1) {
                        //     totalAmountType1 += transaction.amount;
                        //   }
                        // });
                      });
                      num sum = 0;
                      r.units!.forEach((unit) {
                        // unit.transactions.forEach((transaction) {
                        //   if (transaction.type == 2 ||
                        //       transaction.type == 3 ||
                        //       transaction.type == 4 ||
                        //       transaction.type == 6) {
                        //     sum += transaction.amount;
                        //   }
                        // });
                      });
                      // print('object');
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 20),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border:
                                            Border.all(color: Colors.black12)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/save-money.png',
                                          height: 60,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'تومان',
                                                  style: TextStyle(
                                                      fontSize: 8,
                                                      color: Colors.black38,
                                                      fontFamily: 'IR'),
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  sum
                                                      .toStringAsFixed(0)
                                                      .toPersianDigit()
                                                      .seRagham(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'مجموع دریافتی های من',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 20, top: 20),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border:
                                            Border.all(color: Colors.black12)),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/salary.png',
                                          height: 60,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'تومان',
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.black38,
                                                  fontFamily: 'IR'),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              totalAmountType1
                                                  .toStringAsFixed(0)
                                                  .toPersianDigit()
                                                  .seRagham(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'مجموع سرمایه گذاری های من',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child: Text(
                              'سرمایه گذاری ها',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          ListView.builder(
                            controller: _controller,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: r.units!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: BlocProvider(
                                  create: (context) => CertificateBloc(),
                                  child: ShowAllAssetsWidget(
                                      r.units![index], r.user),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                  },
                )
              }
            ],
          );
        },
      ),
    );
  }
}
