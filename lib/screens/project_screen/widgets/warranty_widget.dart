import 'package:flutter/material.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/data/model/warranty/warranty.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'warranty_buttom_sheet.dart';

class WarrantyWidget extends StatefulWidget {
  const WarrantyWidget({super.key, this.waranty});
  final Waranty? waranty;
  @override
  State<WarrantyWidget> createState() => _WarrantyWidgetState();
}

class _WarrantyWidgetState extends State<WarrantyWidget> {
  var gaugeValue;
  var gaugeValueMidPoint;
  List<Color> colorArray = const [
    Color(0xffA3D9FF), // Light sky blue
    Color(0xff63B7FF), // Light blue
    Color(0xff1A91FF), // Bright blue
    Color(0xff0C6FFF), // Rich blue
    Color(0xff0A4FCC), // Dark blue with more contrast
    Color(0xff074EA0), // Primary color (deep blue)
  ];

  @override
  void initState() {
    // TODO: implement initState
    gaugeValue = widget.waranty!.position;
    gaugeValueMidPoint = (6 - gaugeValue) * (100 / 6) + 100 / 12;
    super.initState();
  }

  List<GaugeRange> _buildGaugeRanges() {
    return [
      GaugeRange(
        startValue: 0,
        endValue: 16.6,
        color: colorArray[0],
        startWidth: 15,
        endWidth: 15,
      ),
      GaugeRange(
        startValue: 16.6,
        endValue: 33.3,
        color: colorArray[1],
        startWidth: 15,
        endWidth: 15,
      ),
      GaugeRange(
        startValue: 33.3,
        endValue: 50,
        color: colorArray[2],
        startWidth: 15,
        endWidth: 15,
      ),
      GaugeRange(
        startValue: 50,
        endValue: 66.6,
        color: colorArray[3],
        startWidth: 15,
        endWidth: 15,
      ),
      GaugeRange(
        startValue: 66.6,
        endValue: 83.3,
        color: colorArray[4],
        startWidth: 15,
        endWidth: 15,
      ),
      GaugeRange(
        startValue: 83.3,
        endValue: 100,
        color: colorArray[5],
        startWidth: 15,
        endWidth: 15,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            showDragHandle: true,
            context: context,
            builder: (context) {
              return const WarrantyButtomSheet();
            });
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ضمانت نامه',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 180,
                child: SfRadialGauge(
                  title: GaugeTitle(
                      text: widget.waranty!.title!,
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.black)),
                  axes: <RadialAxis>[
                    RadialAxis(
                      showLabels: false,
                      showAxisLine: false,
                      showTicks: false,
                      minimum: 0,
                      maximum: 100,
                      ranges: _buildGaugeRanges(),
                      pointers: <GaugePointer>[
                        MarkerPointer(
                          value: gaugeValueMidPoint,
                          color: AppColorScheme.scafoldCollor,
                          markerType: MarkerType.circle,
                          markerHeight: 20,
                          markerWidth: 20,
                          enableAnimation: true,
                          text: widget.waranty!.position.toString(),
                          borderWidth: 2,
                          borderColor: AppColorScheme.primaryColor,
                        ),
                        NeedlePointer(
                          value: gaugeValueMidPoint,
                          needleColor:
                              colorArray[6 - widget.waranty!.position!],
                          knobStyle: KnobStyle(
                            knobRadius: 0.10,
                            borderWidth: 0.069,
                            color: Colors.white,
                            borderColor:
                                colorArray[6 - widget.waranty!.position!],
                          ),
                          enableAnimation: true,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
