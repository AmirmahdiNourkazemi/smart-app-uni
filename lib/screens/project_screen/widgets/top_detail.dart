import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartfunding/bloc/auth/401handel/handel_unauth_bloc.dart';
import 'package:smartfunding/bloc/pament_bloc/payment_bloc.dart';
import 'package:smartfunding/bloc/pament_bloc/payment_event.dart';
import 'package:smartfunding/bloc/profile/profile_bloc.dart';
import 'package:smartfunding/constant/color.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/data/model/projects/Projects.dart';
import 'package:smartfunding/utils/auth_manager.dart';
import 'package:smartfunding/utils/error_snack.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../buy & sell/buy_screen.dart';

class TopContainer {
  static Widget buildContainer(
    double? height, {
    required Project project,
    required BuildContext context,
    required double width,
    required bool isDesktop,
    required ScrollController scrollController,
  }) {
    int monthsDifference = project.calculateMonthDifference();

    return Container(
      // width: width,
      // height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Text(
              project.title!,
              style: Theme.of(context).textTheme.titleMedium,
              textDirection: TextDirection.rtl,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 10, right: 20),
          //   child: Text(
          //     widget._project.type == 1
          //         ? "مسکونی"
          //         : widget._project.type == 2
          //             ? "تجاری"
          //             : "تجاری و مسکونی",
          //     style: const TextStyle(
          //         fontFamily: 'IR', fontSize: 14, color: Colors.grey
          //         //fontWeight: FontWeight.w600,
          //         ),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                'تومان',
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                project.fundNeeded
                                    .toString()
                                    .seRagham()
                                    .toPersianDigit(),
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            ':سرمایه مورد نیاز',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                'تومان',
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                project.fundAchieved
                                    .toString()
                                    .toPersianDigit()
                                    .seRagham(),
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            ':سرمایه جذب شده',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SfLinearGauge(
                  animateAxis: true,
                  showLabels: false,
                  showTicks: false,
                  isAxisInversed: true,
                  minimum: 0,
                  ranges: [
                    LinearGaugeRange(
                      rangeShapeType: LinearRangeShapeType.curve,
                      position: LinearElementPosition.cross,

                      startValue: 0,
                      endValue: project.fundAchieved!.toDouble(),
                      startWidth: 27,
                      edgeStyle: LinearEdgeStyle.bothCurve,
                      //endValue: project.fundAchieved!.toDouble(),
                      color: Colors.transparent,
                      child: Shimmer.fromColors(
                        direction: ShimmerDirection.rtl,
                        baseColor: AppColorScheme.primaryColor.withOpacity(1),
                        highlightColor:
                            AppColorScheme.primaryColor.withOpacity(0.8),
                        child: Container(
                          height: 27,
                          decoration: BoxDecoration(
                              color:
                                  AppColorScheme.primaryColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    )
                  ],
                  // labelOffset: 1.2,

                  maximum: project.fundNeeded!.toDouble(),
                  // barPointers: [
                  //   LinearBarPointer(
                  //     //color: Colors.white,

                  //     value: id,
                  //     thickness: 27,
                  //     enableAnimation: true,
                  //     edgeStyle: LinearEdgeStyle.startCurve,
                  //     animationType: LinearAnimationType.elasticOut,
                  //   )
                  // ],

                  axisTrackStyle: const LinearAxisTrackStyle(
                    thickness: 27,
                    //color: Colors.green,
                    edgeStyle: LinearEdgeStyle.bothCurve,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'شناور',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  'روش تامین مالی',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Divider(
              color: Colors.grey.shade200,
              thickness: 0.4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'درصد',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      project.expectedProfit!.toPersianDigit(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                Text(
                  'پیش بینی سود سالیانه',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Divider(
              color: Colors.grey.shade200,
              thickness: 0.4,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'ماه',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      '12'.toPersianDigit(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                Text(
                  "دوره سرمایه گذاری",
                  style: Theme.of(context).textTheme.titleSmall,
                  //textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Divider(
              color: Colors.grey.shade200,
              thickness: 0.4,
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'درصد',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        project.expectedInMounth().toPersianDigit(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Text(
                    "پیش بینی سود سه ماهه",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (AuthMnager.authChangeNotifier.value == '') {
                      showErrorSnackBar(context, 'لطفا ابتدا لاگین کنید');
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) {
                                    PaymentBloc bloc = PaymentBloc();
                                    bloc.add(PaymentStartEvent());
                                    return bloc;
                                  },
                                ),
                                BlocProvider(
                                  create: (context) => ProfileBloc(),
                                ),
                                BlocProvider(create: (context) => HandelBloc())
                              ],
                              child: BuyScreen(project),
                            );
                          },
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: project.status == 1
                        ? AppColorScheme.primaryColor
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minimumSize: Size(
                      isDesktop
                          ? MediaQuery.of(context).size.width * 0.19
                          : MediaQuery.of(context).size.width * 0.8,
                      40,
                    ),
                  ),
                  child: Text(
                    project.status == 1
                        ? 'سرمایه گذاری در طرح'
                        : 'تامین مالی شد',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
