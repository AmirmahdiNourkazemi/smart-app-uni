// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:persian_number_utility/persian_number_utility.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'package:smartfunding/bloc/withdraw/get_withdraw_state.dart';
// import 'package:smartfunding/utils/error_snack.dart';
// import 'package:smartfunding/utils/success_snack.dart';

// import '../../bloc/withdraw/get_withdraw_bloc.dart';
// import '../../bloc/withdraw/get_withdraw_event.dart';
// import '../../constant/scheme.dart';
// import '../../data/model/profile/responseData.dart';
// import '../../utils/cache_image.dart';
// import '../../utils/money_seprator_ir.dart';

// class WithdrawScreen extends StatefulWidget {
//   final ResponseData r;
//   WithdrawScreen(this.r, {super.key});

//   @override
//   State<WithdrawScreen> createState() => _WithdrawScreenState();
// }

// class _WithdrawScreenState extends State<WithdrawScreen> {
//   TextEditingController _priceController = TextEditingController();
//   TextEditingController _iban = TextEditingController();
//   ScrollController _scrollController = ScrollController();
//   final _formKey = GlobalKey<FormState>();

//   String? _selectedIban; // Track the selected IBAN
//   String? ibanText;
//   List<String> ibanList = [];

//   @override
//   Widget build(BuildContext context) {
//     if (widget.r.user.bankAccounts!.isNotEmpty) {
//       ibanText = ibanFormatter.maskText(widget.r.user.bankAccounts![0].iban!);
//       _iban.text = ibanText!;
//     } else {
//       _iban.text = '12345678901';
//     }
//     String? _validateAmount(String? value) {
//       if (value == null || value.isEmpty) {
//         return 'لطفا مبلغ را وارد کنید';
//       }

//       double enteredAmount = double.tryParse(value) ?? 0.0;

//       if (enteredAmount > widget.r.user.wallet!) {
//         return 'مبلغ درخواستی بیشتر از کیف پول است';
//       }

//       return null;
//     }

//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//           title: Text(
//             'برداشت از کیف پول',
//             style: Theme.of(context).textTheme.labelSmall,
//           ),
//           elevation: 0.0,
//           iconTheme: const IconThemeData(
//             color: Colors.black,
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               icon: const Icon(
//                 PhosphorIconsRegular.arrowRight,
//               ),
//             )
//           ],
//           backgroundColor: Colors.white,
//         ),
//         body: Center(
//           child: Container(
//             //height: Responsive.isDesktop(context) ? 800 : 800,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               color: Colors.white,
//             ),
//             child: BlocListener<GetWithdrawBloc, GetWithdrawState>(
//               listener: (context, state) {
//                 if (state is StoreWithdrawResponseState) {
//                   state.storeWithdraw.fold((l) {
//                     showErrorSnackBar(context, l);
//                   }, (r) {
//                     showSuccessSnackBar(context, r);
//                   });
//                 }
//               },
//               child: ListView(
//                 controller: _scrollController,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(
//                         left: 20,
//                         right: 20,
//                         bottom: MediaQuery.of(context).viewInsets.bottom),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         if (widget.r.user.type == 1 &&
//                             widget.r.user.privatePersonInfo != null) ...{
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'نام و نام خانوادگی',
//                                 style: Theme.of(context).textTheme.labelSmall,
//                               ),
//                               Text(
//                                 '${widget.r.user.privatePersonInfo!.firstName!} ${widget.r.user.privatePersonInfo!.lastName!}',
//                                 style: Theme.of(context).textTheme.labelSmall,
//                               ),
//                             ],
//                           ),
//                         },
//                         if (widget.r.user.type == 2 &&
//                             widget.r.user.legalPersonInfo != null) ...{
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'نام شرکت',
//                                 style: Theme.of(context).textTheme.labelSmall,
//                               ),
//                               Text(
//                                 widget.r.user.legalPersonInfo!.name!,
//                                 style: Theme.of(context).textTheme.labelSmall,
//                               ),
//                             ],
//                           ),
//                         },
//                         const SizedBox(
//                           height: 30,
//                           child: Divider(
//                             color: Colors.grey,
//                             thickness: 0.2,
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'کد ملی',
//                               style: Theme.of(context).textTheme.labelSmall,
//                             ),
//                             Text(
//                               widget.r.user.nationalCode
//                                   .toString()
//                                   .toPersianDigit(),
//                               style: Theme.of(context).textTheme.labelSmall,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 30,
//                           child: Divider(
//                             color: Colors.grey,
//                             thickness: 0.2,
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'شماره تلفن',
//                               style: Theme.of(context).textTheme.labelSmall,
//                             ),
//                             Text(
//                               widget.r.user.mobile.toPersianDigit(),
//                               style: Theme.of(context).textTheme.labelSmall,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 30,
//                           child: Divider(
//                             color: Colors.grey,
//                             thickness: 0.2,
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'مبلغ کیف پول',
//                               style: Theme.of(context).textTheme.labelSmall,
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   widget.r.user.wallet
//                                       .toString()
//                                       .toPersianDigit()
//                                       .seRagham(),
//                                   style: Theme.of(context).textTheme.labelSmall,
//                                 ),
//                                 const SizedBox(
//                                   width: 2,
//                                 ),
//                                 Text(
//                                   'تومان',
//                                   style: TextStyle(
//                                       fontSize: 8,
//                                       color: Colors.grey[700],
//                                       fontFamily: 'IR'),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Form(
//                             key: _formKey,
//                             child: Directionality(
//                               textDirection: TextDirection.rtl,
//                               child: Column(
//                                 children: [
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   TextFormField(
//                                     inputFormatters: [
//                                       PersianNumberFormatter(),
//                                     ],
//                                     style:
//                                         Theme.of(context).textTheme.labelSmall,
//                                     controller: _priceController,
//                                     keyboardType: TextInputType.number,
//                                     textAlign: TextAlign.left,
//                                     textDirection: TextDirection.ltr,
//                                     decoration: InputDecoration(
//                                       //contentPadding: EdgeInsets.symmetric(horizontal: 40.0),
//                                       contentPadding:
//                                           const EdgeInsets.symmetric(
//                                               vertical: 8, horizontal: 15),
//                                       enabledBorder: const OutlineInputBorder(
//                                         borderRadius: BorderRadius.all(
//                                           Radius.circular(10),
//                                         ),
//                                       ),
//                                       errorStyle: const TextStyle(
//                                           fontSize: 12,
//                                           color: Colors.red,
//                                           fontFamily: 'IR'),
//                                       labelText: 'میزان درخواست (تومان)',
//                                       labelStyle: const TextStyle(
//                                           fontSize: 10, fontFamily: 'IR'),

//                                       border: const OutlineInputBorder(
//                                         borderRadius: BorderRadius.all(
//                                           Radius.circular(10),
//                                         ),
//                                       ),

//                                       prefixIcon: IconButton(
//                                         icon: const Icon(Icons
//                                             .clear), // Change the icon as needed
//                                         onPressed: () {
//                                           _priceController
//                                               .clear(); // Clears the text field
//                                         },
//                                       ),
//                                     ),
//                                     validator: (value) {
//                                       if (value!.isEmpty) {
//                                         return 'لطفا مبلغ را وارد کنید';
//                                       } else if (widget.r.user.wallet! <=
//                                           int.parse(value
//                                               .replaceAll(',', '')
//                                               .toEnglishDigit())) {
//                                         return 'مبلغ وارد شده بیشتر از کیف پول است';
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   TextFormField(
//                                     controller: _iban,
//                                     keyboardType: TextInputType.number,
//                                     //maxLength: 27,
//                                     textAlign: TextAlign.left,
//                                     inputFormatters: [
//                                       ibanFormatter,
//                                       PersianNumberDigits()
//                                     ],
//                                     readOnly: true,
//                                     textDirection: TextDirection.ltr,
//                                     decoration: const InputDecoration(
//                                       contentPadding: EdgeInsets.symmetric(
//                                           vertical: 8, horizontal: 15),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10)),
//                                       ),
//                                       labelText: 'شماره شبا',
//                                       labelStyle: TextStyle(
//                                           fontSize: 10, fontFamily: 'IR'),
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.all(
//                                           Radius.circular(10),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                         backgroundColor:
//                                             AppColorScheme.primaryColor,
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         fixedSize: Size(
//                                             MediaQuery.of(context).size.width,
//                                             40)),
//                                     onPressed: () {
//                                       final amount = int.parse(_priceController
//                                           .text
//                                           .replaceAll(',', '')
//                                           .toEnglishDigit());

//                                       final iban = _iban.text
//                                           .toEnglishDigit()
//                                           .replaceAll(' ', '');
//                                       if (_formKey.currentState!.validate()) {
//                                         // print(iban);
//                                         // print(amount);
//                                         BlocProvider.of<GetWithdrawBloc>(
//                                                 context)
//                                             .add(StoreWithdrawEvent(
//                                           amount,
//                                           iban,
//                                         ));
//                                       }
//                                     },
//                                     child: const Text(
//                                       'ثبت درخواست',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 12,
//                                           fontFamily: 'IR'),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             )),
//                       ],
//                     ),
//                   ),
//                   BlocBuilder<GetWithdrawBloc, GetWithdrawState>(
//                     builder: (context, state) {
//                       return Column(
//                         children: [
//                           if (state is GetWithdrawLoadingState) ...{
//                             // SpinKitWave(
//                             //   itemBuilder:
//                             //       (BuildContext context, int index) {
//                             //     return DecoratedBox(
//                             //       decoration: BoxDecoration(
//                             //         color: index.isEven
//                             //             ? Colors.blueAccent
//                             //             : const Color(0xff123A99),
//                             //       ),
//                             //     );
//                             //   },
//                             // ),
//                           } else if (state is GetWithdrawResponseState) ...{
//                             state.getWithdraw.fold((l) => Text(l), (withdraw) {
//                               if (withdraw.data.isNotEmpty) {
//                                 return Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Padding(
//                                       padding:
//                                           EdgeInsets.only(right: 20, top: 20),
//                                       child: Text('درخواست ها',
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.bold,
//                                               fontFamily: 'IR')),
//                                     ),
//                                     SizedBox(
//                                       height: withdraw.data.length * 150,
//                                       child: ListView.builder(
//                                         controller: _scrollController,
//                                         itemBuilder: (context, index) {
//                                           return Column(
//                                             children: [
//                                               ListTile(
//                                                 // tileColor: Colors.red,
//                                                 onTap: () {
//                                                   if (withdraw.data[index]
//                                                       .images.isNotEmpty) {
//                                                     showDialog(
//                                                       context: context,
//                                                       builder: (BuildContext
//                                                           context) {
//                                                         return AlertDialog(
//                                                           content: CachedImage(
//                                                             width: 200,
//                                                             height: 200,
//                                                             imageUrl: withdraw
//                                                                 .data[index]
//                                                                 .images[0]
//                                                                 .originalUrl,
//                                                           ),
//                                                           // Adjust width and height as needed for the image
//                                                           // You might need to wrap the Image.network inside a Container with width and height
//                                                         );
//                                                       },
//                                                     );
//                                                   }
//                                                 },

//                                                 selectedColor: Colors.white,

//                                                 trailing: Column(
//                                                   children: [
//                                                     Text(
//                                                       'تاریخ ثبت: ${withdraw.data[index].createdAt.toPersianDate()}',
//                                                       style: const TextStyle(
//                                                           fontSize: 12,
//                                                           fontFamily: 'IR'),
//                                                     ),
//                                                     const SizedBox(
//                                                       height: 4,
//                                                     ),
//                                                     if (withdraw.data[index]
//                                                             .withdrawDate !=
//                                                         null) ...{
//                                                       if (withdraw.data[index]
//                                                               .status ==
//                                                           2) ...{
//                                                         Text(
//                                                           'تاریخ پرداخت: ${withdraw.data[index].withdrawDate.toString().toPersianDate()}',
//                                                           style:
//                                                               const TextStyle(
//                                                                   fontSize: 12,
//                                                                   fontFamily:
//                                                                       'IR'),
//                                                         ),
//                                                       } else if (withdraw
//                                                               .data[index]
//                                                               .status ==
//                                                           3) ...{
//                                                         Text(
//                                                           'تاریخ لغو: ${withdraw.data[index].withdrawDate.toString().toPersianDate()}',
//                                                           style:
//                                                               const TextStyle(
//                                                                   fontSize: 12,
//                                                                   fontFamily:
//                                                                       'IR'),
//                                                         )
//                                                       }
//                                                     }
//                                                   ],
//                                                 ),
//                                                 isThreeLine: true,
//                                                 title: Row(
//                                                   children: [
//                                                     const Text(
//                                                         'مبلغ درخواستی :',
//                                                         style: TextStyle(
//                                                             fontSize: 12,
//                                                             color: Colors.black,
//                                                             fontFamily: 'IR')),
//                                                     Row(
//                                                       children: [
//                                                         Text(
//                                                           withdraw.data[index]
//                                                               .amount
//                                                               .toString()
//                                                               .toPersianDigit()
//                                                               .seRagham(),
//                                                           style:
//                                                               const TextStyle(
//                                                                   fontSize: 12,
//                                                                   color: Colors
//                                                                       .black,
//                                                                   fontFamily:
//                                                                       'IR'),
//                                                         ),
//                                                         const SizedBox(
//                                                           width: 2,
//                                                         ),
//                                                         Text(
//                                                           'تومان',
//                                                           style: TextStyle(
//                                                             fontSize: 8,
//                                                             fontFamily: 'IR',
//                                                             color: Colors
//                                                                 .grey[700],
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 leading: Icon(
//                                                   Icons
//                                                       .currency_exchange_outlined,
//                                                   color: withdraw.data[index]
//                                                               .status ==
//                                                           1
//                                                       ? Colors.blueAccent
//                                                       : withdraw.data[index]
//                                                                   .status ==
//                                                               2
//                                                           ? Colors.green
//                                                           : Colors.red,
//                                                 ),
//                                                 subtitle: Row(
//                                                   children: [
//                                                     const Text('وضعیت :',
//                                                         style: TextStyle(
//                                                             fontSize: 12,
//                                                             color: Colors.black,
//                                                             fontFamily: 'IR')),
//                                                     withdraw.data[index].status ==
//                                                             1
//                                                         ? const Text(
//                                                             'در حال بررسی',
//                                                             style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 color: Colors
//                                                                     .blueAccent,
//                                                                 fontFamily:
//                                                                     'IR'),
//                                                           )
//                                                         : withdraw.data[index]
//                                                                     .status ==
//                                                                 2
//                                                             ? Text('پرداخت شده',
//                                                                 style: TextStyle(
//                                                                     fontSize:
//                                                                         12,
//                                                                     fontFamily:
//                                                                         'IR',
//                                                                     color: Colors
//                                                                             .green[
//                                                                         600]))
//                                                             : Text('لغو شده',
//                                                                 style: TextStyle(
//                                                                     fontSize:
//                                                                         12,
//                                                                     fontFamily:
//                                                                         'IR',
//                                                                     color: Colors
//                                                                             .red[
//                                                                         700]))
//                                                   ],
//                                                 ),
//                                               ),
//                                               const Divider(
//                                                 color: Colors.grey,
//                                                 thickness: 0.2,
//                                               )
//                                             ],
//                                           );
//                                         },
//                                         itemCount: withdraw.data.length,
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               } else {
//                                 return Container();
//                               }
//                             })
//                           }
//                         ],
//                       );
//                     },
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
