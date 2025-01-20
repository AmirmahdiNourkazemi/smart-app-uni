// import 'package:flutter/material.dart';
// import 'package:persian_number_utility/persian_number_utility.dart';
// import 'package:smartfunding/constant/scheme.dart';
// import 'package:smartfunding/data/model/profile/responseData.dart';
// import 'package:smartfunding/screens/profile_screen/redesign/info_container.dart';
// import 'package:smartfunding/utils/devider_widget.dart';


// class BankDetailWidget extends StatelessWidget {
//   final ResponseData r;
//   const BankDetailWidget({super.key, required this.r});

//   @override
//   Widget build(BuildContext context) {
//     return InfoContainer(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'مشخصات حساب بانکی',
//             style: Theme.of(context)
//                 .textTheme
//                 .headlineLarge!
//                 .copyWith(color: Colors.black),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           if (r.user.bankAccounts != null &&
//               r.user.bankAccounts![0].iban!.isNotEmpty) ...{
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('شماره شبا',
//                        style: Theme.of(context).textTheme.titleSmall,),
               
//                 Text(r.user.bankAccounts![0].iban!.toPersianDigit(),
//                         style: Theme.of(context).textTheme.titleSmall,),
//               ],
//             ),
           
//           },
//           if (r.user.bankAccounts != null &&
//               r.user.bankAccounts![0].number != null) ...{
//                  deviderWidget(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('شماره حساب',
//                         style: Theme.of(context).textTheme.titleSmall,),
                
//                 Row(
//                   children: [
//                     Text(r.user.bankAccounts![0].number!.toPersianDigit(),
//                           style: Theme.of(context).textTheme.titleSmall,),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       r.user.bankAccounts![0].bankName!,
//                       style: const TextStyle(
//                         fontSize: 10,
//                         fontFamily: 'IR',
//                         color: AppColorScheme.primaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
           
//           },
//           if (r.user.tradingAccounts != null &&
//               r.user.tradingAccounts![0].code!.isNotEmpty) ...{
//                  deviderWidget(),
//             Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('کد بورسی',
//                         style: Theme.of(context).textTheme.titleSmall,),
         
//                 Text(r.user.tradingAccounts![0].code!.toPersianDigit(),
//                       style: Theme.of(context).textTheme.titleSmall,),
//               ],
//             ),
          
//           },
//           if (r.user.legalPersonInfo != null &&
//               r.user.type == 2 &&
//               r.user.legalPersonInfo!.economicCode != null) ...{
//                  deviderWidget(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('کد اقتصادی',
//                     style: Theme.of(context)
//                         .textTheme
//                         .headlineLarge!
//                         .copyWith(color: Colors.black)),
                
//                 Text(r.user.legalPersonInfo!.economicCode!.toPersianDigit(),
//                     style: Theme.of(context)
//                         .textTheme
//                         .headlineLarge!
//                         .copyWith(color: Colors.black)),
//               ],
//             ),
         
//           },
//           if (r.user.legalPersonInfo != null &&
//               r.user.legalPersonInfo!.registerNumber != null &&
//               r.user.type == 2) ...{
//                  deviderWidget(),
//             Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('شماره ثبت',
//                     style: Theme.of(context)
//                         .textTheme
//                         .headlineLarge!
//                         .copyWith(color: Colors.black)),
               
//                 Text(r.user.legalPersonInfo!.registerNumber!.toPersianDigit(),
//                     style: Theme.of(context)
//                         .textTheme
//                         .headlineLarge!
//                         .copyWith(color: Colors.black)),
//               ],
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//           },
//           if (r.user.legalPersonInfo != null &&
//               r.user.legalPersonInfo!.registerPlace != null &&
//               r.user.type == 2) ...{
//                  deviderWidget(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('محل ثبت',
//                     style: Theme.of(context)
//                         .textTheme
//                         .headlineLarge!
//                         .copyWith(color: Colors.black)),
               
//                 Text(r.user.legalPersonInfo!.registerPlace!,
//                     style: Theme.of(context)
//                         .textTheme
//                         .headlineLarge!
//                         .copyWith(color: Colors.black)),
//               ],
//             ),
          
//           },
//         ],
//       ),
//     );
//   }
// }
