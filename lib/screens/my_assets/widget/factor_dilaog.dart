import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smartfunding/data/model/profile/transaction.dart';

Widget FactorAlertDialoadContainer(List<Transaction> trade) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: trade.length,
    physics: const NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemBuilder: (context, index) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Chip(
                    color: const WidgetStatePropertyAll(Color(0xffEBEBEB)),
                    avatar: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Icon(
                          PhosphorIcons.hash(),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    label: Text('تراکنش ${index + 1}',
                        style: Theme.of(context).textTheme.titleMedium),
                    elevation: 20,
                    side: const BorderSide(
                      color: Color(0xffEBEBEB),
                    ),
                    labelPadding: EdgeInsets.zero,
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Chip(
                    color: const WidgetStatePropertyAll(Color(0xffEBEBEB)),
                    avatar: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Icon(
                          trade[index].type == 1
                              ? PhosphorIcons.trendDown()
                              : PhosphorIcons.trendUp(),
                          color: trade[index].type == 1
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                    ),
                    label: Text(
                        trade[index].type == 1 ? 'سرمایه گذاری' : 'واریز سود',
                        style: Theme.of(context).textTheme.titleMedium),
                    elevation: 20,
                    side: const BorderSide(
                      color: Color(0xffEBEBEB),
                    ),
                    labelPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    trade[index].amount.toString().toPersianDigit().seRagham(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: const Color(0xff808080)),
                  ),
                ],
              ),
              trade[index].type == 3
                  ? Text(
                      'مبلغ واریزی',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: const Color(0xff808080)),
                    )
                  : Text(
                      'مبلغ سرمایه گذاری',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: const Color(0xff808080)),
                    ),
            ],
          ),
          const SizedBox(
            height: 15,
            child: Divider(
              color: Colors.black12,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                trade[index].createdAt.toPersianDate(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: const Color(0xff808080)),
              ),
              trade[index].type == 1
                  ? Text(
                      'تاریخ سرمایه گذاری',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: const Color(0xff808080)),
                    )
                  : Text(
                      'تاریخ واریزی',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: const Color(0xff808080)),
                    )
            ],
          ),
          const SizedBox(
            height: 15,
            child: Divider(
              color: Colors.black12,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  trade[index].type == 1 ? 'سرمایه گذاری' : 'واریز سود',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: const Color(0xff808080)),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                'وضعیت',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: const Color(0xff808080)),
              )
            ],
          ),
         
          if (index != trade.length - 1) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 0),
              child: Divider(color: Colors.black12, thickness: 0.4),
            ),
          ]
        ],
      );
    },
  );
}
