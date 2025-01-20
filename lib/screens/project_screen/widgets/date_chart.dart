import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/data/model/projects/Projects.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:timelines/timelines.dart';

class DateChart {
  static Widget buildContainer(
    double? height, {
    required Project project,
    required BuildContext context,
    required double width,
    required bool isDesktop,
    required ScrollController scrollController,
  }) {
    bool isTimePassed(DateTime projectTime) {
      DateTime now = DateTime.now();
      return now.isAfter(projectTime);
    }

    Color getConnectorColor(DateTime currentDate, DateTime nextDate) {
      return isTimePassed(currentDate) && isTimePassed(nextDate)
          ? Color(0xFF074EA0)
          : Colors.grey[500]!;
    }

    @override
    String createAt =
        'انتشار اولیه طرح: ${project.createdAt.toString().toEnglishDigit().toPersianDate()}';
    String startedAt =
        'شروع طرح: ${project.startAt.toString().toEnglishDigit().toPersianDate()}';
    String finishedAt =
        'پایان طرح: ${project.finishAt.toString().toEnglishDigit().toPersianDate()}';
    return project.timeTable == null
        ? Container()
        : Container(
            padding: const EdgeInsets.all(10),
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

            // elevation: 3,
            margin: EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: FixedTimeline.tileBuilder(
                builder: TimelineTileBuilder.connected(
                  contentsAlign: ContentsAlign.basic,
                  oppositeContentsBuilder: (context, index) {
                    final item = project.timeTable![index];
                    final currentDate = DateTime.parse(item['date']);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        textDirection: TextDirection.rtl,
                        DateTime.parse(item["date"]).toPersianDateStr(),
                        style: isTimePassed(currentDate)
                            ? Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColorScheme.primaryColor
                            )
                            :  Theme.of(context).textTheme.titleSmall!.copyWith(
                              color:Colors.grey
                            ),
                      ),
                    );
                  },
                  contentsBuilder: (context, index) {
                    final item = project.timeTable![index];
                    final currentDate = DateTime.parse(item['date']);
                    return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          item['title'],
                          style: isTimePassed(currentDate)
                              ? Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColorScheme.primaryColor
                            )
                              : Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.grey
                            ),
                        ));
                  },
                  connectorBuilder: (context, index, type) {
                    final currentDate =
                        DateTime.parse(project.timeTable![index]['date']);
                    final nextDate = index < project.timeTable!.length - 1
                        ? DateTime.parse(project.timeTable![index + 1]['date'])
                        : null;

                    return SolidLineConnector(
                      color: nextDate != null
                          ? getConnectorColor(currentDate, nextDate)
                          : Colors.transparent,
                    );
                  },
                  indicatorBuilder: (context, index) {
                    final item = project.timeTable![index];
                    final currentDate = DateTime.parse(item['date']);
                    return DotIndicator(
                      size: 32,
                      color: Colors.transparent,
                      child: Icon(
                        isTimePassed(currentDate)
                            ? PhosphorIcons.checkCircle()
                            : Icons.cancel,
                        color: isTimePassed(currentDate)
                            ? Color(0xFF074EA0)
                            : Colors.grey,
                      ),
                    );
                  },
                  itemCount: project.timeTable!.length,
                ),
              ),
            ),
          );
  }
}
