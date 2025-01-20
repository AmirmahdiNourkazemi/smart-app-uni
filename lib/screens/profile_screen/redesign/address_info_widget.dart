
// import 'package:flutter/material.dart';
// import 'package:persian_number_utility/persian_number_utility.dart';
// import 'package:smartfunding/screens/profile_screen/redesign/info_container.dart';

// import '../../../data/model/profile/responseData.dart';

// class AddressInfoWidget extends StatelessWidget {
//    final ResponseData r;
//   const AddressInfoWidget({super.key , required this.r});

//   @override
//   Widget build(BuildContext context) {
//     return InfoContainer(
//       child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//                Text(
//             'مشخصات محل سکونت',
//             style: Theme.of(context)
//                 .textTheme
//                 .headlineLarge!
//                 .copyWith(color: Colors.black),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   if (r.user.addresses!.isNotEmpty)
//                   Text(
//                     'کد پستی',
//                         style: Theme.of(context).textTheme.titleSmall,
//                   ),
                  
//                   if (r.user.addresses!.isNotEmpty)
//                     Text(
//                       r.user.addresses![0].postalCode!.toPersianDigit(),
//                          style: Theme.of(context).textTheme.titleSmall,
//                     ),
//                 ],
//               ),
//                 const SizedBox(
//             height: 8,
//           ),
         
//             ],
//           ),
//     );
//   }
// }