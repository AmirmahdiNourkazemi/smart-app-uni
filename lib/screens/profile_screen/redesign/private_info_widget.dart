import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:smartfunding/data/model/profile/responseData.dart';
import 'package:smartfunding/screens/profile_screen/redesign/info_container.dart';
import 'package:smartfunding/utils/devider_widget.dart';

class PrivateinfoWidget extends StatelessWidget {
  final ResponseData r;
  const PrivateinfoWidget({
    required this.r,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InfoContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'مشخصات فردی',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          if (r.user.type == 1 && r.user.fullName != null) ...{
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'نام و نام خانوادگی',
                 style: Theme.of(context).textTheme.titleSmall,
                ),
                
                Text(
                  r.user.fullName!,
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),  deviderWidget(),
          },
          if (r.user.type == 2 && r.user.fullName != null) ...{
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'نام شرکت',
                     style: Theme.of(context).textTheme.titleSmall,
                  ),
               
                  Text(
                    r.user.fullName!,
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ]),
          
          deviderWidget()
          },
         
          if (r.user.mobile.isNotEmpty) ...{
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'شماره موبایل',
                      style: Theme.of(context).textTheme.titleSmall,
                  ),
                   
                  Text(
                    r.user.mobile.toString().toPersianDigit(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ]),
                 const SizedBox(
            height: 8,
          ),
          
          },
        ],
      ),
    );
  }
}
