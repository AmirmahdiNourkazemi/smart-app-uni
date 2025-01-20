import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartfunding/constant/color.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/screens/project_screen/navigate_detail_project.dart';
import 'package:smartfunding/utils/devider_widget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../data/model/projects/Projects.dart';
import '../../../utils/cache_image.dart';

class ProjectDashboardContainer extends StatelessWidget {
  final Project _project;
  const ProjectDashboardContainer(this._project, {super.key});

  @override
  Widget build(BuildContext context) {
    double mounth = double.parse(_project.expectedProfit!) / 12;
    // print(_project.images![0].originalUrl);
    int monthsDifference = _project.calculateMonthDifference();
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: 200,
      //height: 200,
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 220,
              child: _project.images!.first != ''
                  ? Hero(
                      tag: _project.id!,
                      child: CachedImage(
                        imageUrl: _project.images![0].originalUrl,
                        topLeftradious: 10,
                        topRightradious: 10,
                        bottomLeftradious: 10,
                        bottomRightradious: 10,
                      ),
                    )
                  : SizedBox(
                      child: Image.asset(
                        "assets/images/placeholder.png",
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                maxLines: 1,
                _project.title!,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(height: 2),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.rtl,
              ),
            ),
           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'درصد',
                        style: TextStyle(
                          fontSize: 9,
                          fontFamily: 'IR',
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        _project.expectedProfit!.toPersianDigit(),
                         style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'پیش بینی سود سالیانه',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            deviderSmallWidget(MediaQuery.of(context).size.width * 0.8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'ماه',
                        style: TextStyle(
                          fontSize: 9,
                          fontFamily: 'IR',
                          color: Colors.grey[700],
                        ),
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
            deviderSmallWidget(MediaQuery.of(context).size.width * 0.8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'درصد',
                        style: TextStyle(
                          fontFamily: 'IR',
                          fontSize: 9,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        _project.expectedInMounth().toPersianDigit(),
                       style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Text(
                    "پیش بینی سود سه ماهه",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            deviderSmallWidget(MediaQuery.of(context).size.width * 0.8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'تومان',
                        style: TextStyle(
                          fontSize: 9,
                          fontFamily: 'IR',
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      if (_project.fundAchieved != null) ...{
                        Text(
                          _project.fundAchieved
                              .toString()
                              .toPersianDigit()
                              .seRagham(),
                           style: Theme.of(context).textTheme.titleSmall,
                        ),
                      } else ...{
                        Text(
                          '0'.toPersianDigit(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      }
                    ],
                  ),
                  Text(
                    "مبلغ تامین شده",
                    style: Theme.of(context).textTheme.titleSmall,
                    //textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            deviderSmallWidget(MediaQuery.of(context).size.width * 0.8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                'تومان',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontFamily: 'IR',
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                _project.fundNeeded
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
                                style: TextStyle(
                                  fontSize: 8,
                                  fontFamily: 'IR',
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                _project.fundAchieved
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
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.79,
                          child: SfLinearGauge(
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
                                endValue: _project.fundAchieved!.toDouble(),
                                startWidth: 22,
                                edgeStyle: LinearEdgeStyle.bothCurve,
                                //endValue: project.fundAchieved!.toDouble(),
                                color: Colors.transparent,
                                child: Shimmer.fromColors(
                                  direction: ShimmerDirection.rtl,
                                  baseColor: AppColorScheme.primaryColor
                                      .withOpacity(1),
                                  highlightColor: AppColorScheme.primaryColor
                                      .withOpacity(0.8),
                                  child: Container(
                                    height: 22,
                                    decoration: BoxDecoration(
                                        color: AppColorScheme.primaryColor
                                            .withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                              )
                            ],
                            maximum: _project.fundNeeded!.toDouble(),
                            axisTrackStyle: const LinearAxisTrackStyle(
                              thickness: 22,
                              //color: Colors.green,
                              edgeStyle: LinearEdgeStyle.bothCurve,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.79,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return NavigateDetailProject(_project);
                  }));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: _project.status == 1
                        ? AppColors.primaryColor
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text(
                  _project.status == 1
                      ? 'سرمایه گذاری در طرح'
                      : 'تامین مالی شد',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
