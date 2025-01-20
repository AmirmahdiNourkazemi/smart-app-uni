import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/data/model/projects/Projects.dart';
import 'package:smartfunding/utils/money_seprator_ir.dart';

class CalculatorWidget extends StatefulWidget {
  final Project project;
  final double width;
  final double height;

  const CalculatorWidget({
    Key? key,
    required this.project,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  late TextEditingController _calculateController;
  String calculator = '0';
  int decrease = 0;
  @override
  void initState() {
    super.initState();
    _calculateController = TextEditingController();
    _calculateController.addListener(_updateMeterValue);
  }

  @override
  void dispose() {
    _calculateController.dispose();
    super.dispose();
  }

  void _updateMeterValue() {
    double price = double.tryParse(
            _calculateController.text.replaceAll(',', '').toEnglishDigit()) ??
        0.0;
    double expected =
        double.parse(widget.project.expectedProfit.toString()) / 100;
    expected += 1;
    double calcute = (price * expected);

    ///print(_calculateController.text);
//print(calcute);
    setState(() {
      calculator = calcute.toStringAsFixed(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'محاسبه گر',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: widget.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    style: const TextStyle(fontFamily: 'IR', fontSize: 12),
                    keyboardType: TextInputType.number,
                    controller: _calculateController,
                    inputFormatters: [PersianNumberFormatter()],
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    enableIMEPersonalizedLearning: true,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                          onPressed: () {
                            double increase = double.tryParse(
                                    _calculateController.text
                                        .replaceAll(',', '')
                                        .toEnglishDigit()) ??
                                0;
                            increase += 1000000;
                            _calculateController.clear();
                            _calculateController.text += increase
                                .toStringAsFixed(0)
                                .toPersianDigit()
                                .seRagham();
                          },
                          icon: const PhosphorIcon(
                            PhosphorIconsRegular.plus,
                            size: 22,
                            color: Colors.black87,
                          )),
                      suffixIcon: IconButton(
                          onPressed: () {
                            double increase = double.tryParse(
                                    _calculateController.text
                                        .replaceAll(',', '')
                                        .toEnglishDigit()) ??
                                0;
                            increase -= 1000000;
                            if (increase > 0) {
                              _calculateController.clear();
                              _calculateController.text += increase
                                  .toStringAsFixed(0)
                                  .toPersianDigit()
                                  .seRagham();
                            }
                          },
                          icon: const PhosphorIcon(
                            PhosphorIconsRegular.minus,
                            color: Colors.black87,
                            size: 22,
                          )),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 15),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      labelText: 'مبلغ سرمایه گذاری (تومان)',
                      labelStyle: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'IR',
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: AppColorScheme.primaryColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                          width: 3,
                        ),
                        Text(
                          widget.project.minInvest
                              .toString()
                              .toPersianDigit()
                              .seRagham(),
                          style: TextStyle(
                            fontFamily: 'IR',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      ':حداقل سرمایه گذاری',
                      style: TextStyle(
                        fontFamily: 'IR',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'پیش بینی برگشتی شما',
                      style: TextStyle(
                        fontFamily: 'IR',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: AppColorScheme.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          width: 3,
                        ),
                        Text(
                          calculator.toPersianDigit().seRagham(),
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColorScheme.primaryColor,
                            fontFamily: 'IR',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
