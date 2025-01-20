// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:persian_number_utility/persian_number_utility.dart';
// import 'package:smartfunding/bloc/pament_bloc/payment_bloc.dart';
// import 'package:smartfunding/bloc/pament_bloc/payment_event.dart';
// import 'package:smartfunding/bloc/pament_bloc/payment_state.dart';
// import 'package:smartfunding/constant/scheme.dart';
// import 'package:smartfunding/data/model/profile/responseData.dart';
// import 'package:smartfunding/utils/error_snack.dart';
// import 'package:smartfunding/utils/money_seprator_ir.dart';
// import 'package:url_launcher/url_launcher.dart';

// class DepositGatway extends StatefulWidget {
//   final ResponseData r;
//   const DepositGatway({required this.r, super.key});

//   @override
//   State<DepositGatway> createState() => _DepositGatwayState();
// }

// class _DepositGatwayState extends State<DepositGatway> {
//   bool isCardnumber = false;

//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _priceController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<PaymentBloc, PaymentState>(
//       listener: (context, state) {
//         if (state is DepositResponseState) {
//           state.goToPayment.fold((l) {
//             showErrorSnackBar(context, l);
//           }, (r) async {
//             await launch(r);
//           });
//         }
//       },
//       child: ListView(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//                 left: 20,
//                 right: 20,
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 if (widget.r.user.type == 1 &&
//                     widget.r.user.privatePersonInfo != null) ...{
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'نام و نام خانوادگی',
//                         style: Theme.of(context).textTheme.labelSmall,
//                       ),
//                       Text(
//                         '${widget.r.user.privatePersonInfo!.firstName!} ${widget.r.user.privatePersonInfo!.lastName!}',
//                         style: Theme.of(context).textTheme.labelSmall,
//                       ),
//                     ],
//                   ),
//                 },
//                 if (widget.r.user.type == 2 &&
//                     widget.r.user.legalPersonInfo != null) ...{
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'نام شرکت',
//                         style: Theme.of(context).textTheme.labelSmall,
//                       ),
//                       Text(
//                         widget.r.user.legalPersonInfo!.name!,
//                         style: Theme.of(context).textTheme.labelSmall,
//                       ),
//                     ],
//                   ),
//                 },
//                 const SizedBox(
//                   height: 30,
//                   child: Divider(
//                     color: Colors.grey,
//                     thickness: 0.2,
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'کد ملی',
//                       style: Theme.of(context).textTheme.labelSmall,
//                     ),
//                     Text(
//                       widget.r.user.nationalCode.toString().toPersianDigit(),
//                       style: Theme.of(context).textTheme.labelSmall,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 30,
//                   child: Divider(
//                     color: Colors.grey,
//                     thickness: 0.2,
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'شماره تلفن',
//                       style: Theme.of(context).textTheme.labelSmall,
//                     ),
//                     Text(
//                       widget.r.user.mobile.toPersianDigit(),
//                       style: Theme.of(context).textTheme.labelSmall,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 30,
//                   child: Divider(
//                     color: Colors.grey,
//                     thickness: 0.2,
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'مبلغ کیف پول',
//                       style: Theme.of(context).textTheme.labelSmall,
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           widget.r.user.wallet
//                               .toString()
//                               .toPersianDigit()
//                               .seRagham(),
//                           style: Theme.of(context).textTheme.labelSmall,
//                         ),
//                         const SizedBox(
//                           width: 2,
//                         ),
//                         Text(
//                           'تومان',
//                           style: TextStyle(
//                               fontSize: 8,
//                               color: Colors.grey[700],
//                               fontFamily: 'IR'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Form(
//                     key: _formKey,
//                     child: Directionality(
//                       textDirection: TextDirection.rtl,
//                       child: Column(
//                         children: [
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           TextFormField(
//                             inputFormatters: [
//                               PersianNumberFormatter(),
//                             ],
//                             style:
//                                 const TextStyle(fontSize: 12, fontFamily: 'IR'),
//                             controller: _priceController,
//                             keyboardType: TextInputType.number,
//                             textAlign: TextAlign.center,
//                             textDirection: TextDirection.ltr,
//                             decoration: InputDecoration(
//                               //contentPadding: EdgeInsets.symmetric(horizontal: 40.0),
//                               contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 8, horizontal: 15),
//                               enabledBorder: const OutlineInputBorder(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(10),
//                                 ),
//                               ),
//                               errorStyle: const TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.red,
//                                   fontFamily: 'IR'),
//                               labelText: 'میزان درخواست (تومان)',
//                               labelStyle: const TextStyle(
//                                   fontSize: 10, fontFamily: 'IR'),

//                               border: const OutlineInputBorder(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(10),
//                                 ),
//                               ),

//                               prefixIcon: IconButton(
//                                 icon: const Icon(
//                                     Icons.clear), // Change the icon as needed
//                                 onPressed: () {
//                                   _priceController
//                                       .clear(); // Clears the text field
//                                 },
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'لطفا مبلغ را وارد کنید';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: AppColorScheme.primaryColor,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10)),
//                                 fixedSize: Size(
//                                     MediaQuery.of(context).size.width, 40)),
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 final amount = int.parse(_priceController.text
//                                     .replaceAll(',', '')
//                                     .toEnglishDigit());

//                                 // print(account);
//                                 BlocProvider.of<PaymentBloc>(context)
//                                     .add(DipositWalletEvent(amount.toString()));
//                               }
//                             },
//                             child: BlocBuilder<PaymentBloc, PaymentState>(
//                               builder: (context, state) {
//                                 if (state is DisposeLoadingState) {
//                                   return const Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         'در حال انتقال به درگاه',
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 12,
//                                             fontFamily: 'IR'),
//                                       ),
//                                       SizedBox(
//                                         width: 4,
//                                       ),
//                                       SizedBox(
//                                         height: 30,
//                                         child: CircularProgressIndicator(
//                                           color: Colors.white,
//                                         ),
//                                       )
//                                     ],
//                                   );
//                                 }
//                                 return const Text(
//                                   'ادامه',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 12,
//                                       fontFamily: 'IR'),
//                                 );
//                               },
//                             ),
//                           )
//                         ],
//                       ),
//                     )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// // Widget depositGatway(BuildContext context, ResponseData r) {

// // }
