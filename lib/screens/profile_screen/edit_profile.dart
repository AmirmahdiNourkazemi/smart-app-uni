// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:persian_number_utility/persian_number_utility.dart';
// import 'package:smartfunding/bloc/auth/edit_profile/edit_profile_bloc.dart';
// import 'package:smartfunding/bloc/auth/edit_profile/edit_profile_event.dart';
// import 'package:smartfunding/bloc/auth/edit_profile/edit_profile_state.dart';
// import 'package:smartfunding/bloc/projects/project_bloc.dart';
// import 'package:smartfunding/constant/scheme.dart';
// import 'package:smartfunding/data/model/profile/user.dart';
// import 'package:smartfunding/screens/dashboard_screen.dart';
// import 'package:smartfunding/utils/auth_manager.dart';
// import 'package:smartfunding/utils/error_snack.dart';
// import 'package:smartfunding/utils/money_seprator_ir.dart';
// import 'package:smartfunding/utils/success_snack.dart';

// class EditProfile extends StatefulWidget {
//   final User user;
//   const EditProfile({super.key, required this.user});

//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile> {
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController nationalCodeController = TextEditingController();
//   TextEditingController companyNameController = TextEditingController();
//   TextEditingController sajamCodeController = TextEditingController();
//   TextEditingController ibanCodeController = TextEditingController();
//   int? selectedOption;
//   @override
//   void initState() {
//     // TODO: implement initState
//     selectedOption = widget.user.type!;
//     if (selectedOption == 1) {
     
//     } else {
//       companyNameController.text =
//           widget.user.fullName != null ? widget.user.fullName! : '';
//     }
//     nationalCodeController.text =
//         widget.user.nationalCode != null ? widget.user.nationalCode! : '';
   
//     super.initState();
//   }

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<EditProfileBloc, EditProfileState>(
//       listener: (context, state) {
//         if (state is EditProfileResponseState) {
//           state.editProfile.fold((l) => showErrorSnackBar(context, l), (r) {
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(
//                 builder: (context) {
//                   return BlocProvider(
//                     create: (context) => ProjectBloc(),
//                     child: const DashboardScreen(
//                       selected: 2,
//                     ),
//                   );
//                 },
//               ),
//             );
//             showSuccessSnackBar(context, 'ویرایش با موفقیت انجام شد');
//           });
//         }
//       },
//       child: Directionality(
//         textDirection: TextDirection.rtl,
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           appBar: AppBar(
//             automaticallyImplyLeading: false,
//             centerTitle: true,
//             actions: [
//               IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(Icons.arrow_forward))
//             ],
//             backgroundColor: Colors.white,
//             title: const Text(
//               'ویرایش',
//               style: TextStyle(
//                   fontSize: 14.0,
//                   fontFamily: 'IR',
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black),
//             ),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: ListView(
//               shrinkWrap: true,
//               children: [
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Visibility(
//                         visible: selectedOption == 1,
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 15),
//                           child: TextFormField(
//                             textDirection: TextDirection.ltr,
//                             textAlign: TextAlign.center,
//                             cursorHeight: 19,
//                             style: Theme.of(context).textTheme.titleMedium,
//                             keyboardType: TextInputType.text,
//                             controller: firstNameController,
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: Colors.white,
//                               contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 15, horizontal: 10),
//                               border: const OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.black,
//                                   width: 0.5,
//                                 ),
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(7),
//                                 ),
//                               ),
//                               labelText: 'نام',
//                               labelStyle:
//                                   Theme.of(context).textTheme.titleMedium,
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(7),
//                                 borderSide: const BorderSide(
//                                   color: AppColorScheme.primaryColor,
//                                   width: 0.5,
//                                 ),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (selectedOption == 1 && value!.isEmpty) {
//                                 return 'نام را وارد کنید';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                       ),
//                       Visibility(
//                         visible: selectedOption == 1,
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 15),
//                           child: TextFormField(
//                             textDirection: TextDirection.ltr,
//                             textAlign: TextAlign.center,
//                             cursorHeight: 19,
//                             style: Theme.of(context).textTheme.titleMedium,
//                             keyboardType: TextInputType.text,
//                             controller: lastNameController,
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: Colors.white,
//                               contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 15, horizontal: 10),
//                               border: const OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.black,
//                                   width: 0.5,
//                                 ),
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(7),
//                                 ),
//                               ),
//                               labelText: 'نام خانوادگی',
//                               labelStyle:
//                                   Theme.of(context).textTheme.titleMedium,
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(7),
//                                 borderSide: const BorderSide(
//                                   color: AppColorScheme.primaryColor,
//                                   width: 0.5,
//                                 ),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (selectedOption == 1 && value!.isEmpty) {
//                                 return 'نام خانوادگی را وارد کنید';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                       ),
//                       Visibility(
//                         visible: selectedOption == 2,
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 15),
//                           child: TextFormField(
//                             cursorHeight: 19,
//                             textDirection: TextDirection.ltr,
//                             textAlign: TextAlign.center,
//                             style: Theme.of(context).textTheme.titleMedium,
//                             keyboardType: TextInputType.text,
//                             controller: companyNameController,
//                             decoration: InputDecoration(
//                               filled: true,
//                               fillColor: Colors.white,
//                               contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 15, horizontal: 10),
//                               border: const OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.black,
//                                   width: 0.5,
//                                 ),
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(7),
//                                 ),
//                               ),
//                               labelText: 'نام شرکت',
//                               labelStyle:
//                                   Theme.of(context).textTheme.titleMedium,
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(7),
//                                 borderSide: const BorderSide(
//                                   color: AppColorScheme.primaryColor,
//                                   width: 0.5,
//                                 ),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (selectedOption == 2 && value!.isEmpty) {
//                                 return 'نام شرکت را وارد کنید';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 15),
//                         child: TextFormField(
//                           cursorHeight: 19,
//                           textDirection: TextDirection.ltr,
//                           textAlign: TextAlign.center,
//                           style: Theme.of(context).textTheme.titleMedium,
//                           readOnly: true,
//                           keyboardType: TextInputType.number,
//                           controller: nationalCodeController,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white,
//                             contentPadding: const EdgeInsets.symmetric(
//                                 vertical: 15, horizontal: 10),
//                             border: const OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.black,
//                                 width: 0.5,
//                               ),
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(7),
//                               ),
//                             ),
//                             labelText:
//                                 selectedOption == 1 ? 'کدملی' : 'شناسه ملی',
//                             labelStyle: Theme.of(context).textTheme.titleMedium,
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                 color: AppColorScheme.primaryColor,
//                                 width: 0.5,
//                               ),
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'کدملی یا شناسه ملی را وارد کنید';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 15),
//                         child: TextFormField(
//                           cursorHeight: 19,
//                           style: Theme.of(context).textTheme.titleMedium,
//                           keyboardType: TextInputType.text,
//                           controller: sajamCodeController,
//                           textDirection: TextDirection.ltr,
//                           textAlign: TextAlign.center,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white,
//                             contentPadding: const EdgeInsets.symmetric(
//                                 vertical: 15, horizontal: 10),
//                             border: const OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.black,
//                                 width: 0.5,
//                               ),
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(7),
//                               ),
//                             ),
//                             labelText: 'کد بورسی',
//                             labelStyle: Theme.of(context).textTheme.titleMedium,
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                 color: AppColorScheme.primaryColor,
//                                 width: 0.5,
//                               ),
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'کد بورسی را وارد کنید';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 15),
//                         child: TextFormField(
//                           textDirection: TextDirection.ltr,
//                           textAlign: TextAlign.center,
//                           cursorHeight: 19,
//                           style: Theme.of(context).textTheme.titleMedium,
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [
//                             ibanFormatter,
//                           ],
//                           controller: ibanCodeController,
//                           decoration: InputDecoration(
//                             suffix: Text(
//                               'IR',
//                               style: TextStyle(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.bold,
//                                   color: Theme.of(context).primaryColor,
//                                   letterSpacing: 1.4,
//                                   decorationThickness: 2.5),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                             contentPadding: const EdgeInsets.symmetric(
//                               vertical: 15,
//                               horizontal: 10,
//                             ),
//                             border: const OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.black,
//                                 width: 0.5,
//                               ),
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(7),
//                               ),
//                             ),
//                             labelText: 'شماره شبا',
//                             labelStyle: Theme.of(context).textTheme.titleMedium,
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: const BorderSide(
//                                 color: AppColorScheme.primaryColor,
//                                 width: 0.5,
//                               ),
//                             ),
//                           ),
//                           validator: (value) {
//                             final formattedIban = value?.replaceAll(' ', '');
//                             if (formattedIban!.isEmpty) {
//                               return 'کد شبا را وارد کنید';
//                             } else if (formattedIban.length != 24) {
//                               return 'لطفا کد شبا را به صورت صحیح وارد کنید';
//                             } else if (formattedIban
//                                 .toUpperCase()
//                                 .startsWith('IR')) {
//                               return 'لطفا بدون IR وارد کنید';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 15),
//                         child: BlocBuilder<EditProfileBloc, EditProfileState>(
//                           builder: (context, state) {
//                             return ElevatedButton(
//                               style: ButtonStyle(
//                                 backgroundColor: MaterialStatePropertyAll(
//                                     state is EditProfileLoadingState
//                                         ? Colors.grey
//                                         : AppColorScheme.primaryColor),
//                                 shape: MaterialStatePropertyAll<
//                                         RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 )),
//                               ),
//                               onPressed: () {
//                                 // if (_formKey.currentState!.validate()) {
//                                 //   var iban =
//                                 //       'IR${ibanCodeController.text.replaceAll(' ', '')}';

//                                 //   if (selectedOption == 1) {
//                                 //     BlocProvider.of<EditProfileBloc>(context)
//                                 //         .add(
//                                 //       EditProfileButtonClickEvent(
//                                 //           firstNameController.text,
//                                 //           lastNameController.text,
//                                 //           '',
//                                 //           selectedOption!,
//                                 //           sajamCodeController.text,
//                                 //           widget.user.tradingAccounts![0].id,
//                                 //           iban,
//                                 //           widget.user.bankAccounts![0].id,
//                                 //           nationalCodeController.text
//                                 //               .toEnglishDigit()),
//                                 //     );
//                                 //   } else {
//                                 //     BlocProvider.of<EditProfileBloc>(context)
//                                 //         .add(
//                                 //       EditProfileButtonClickEvent(
//                                 //           '',
//                                 //           '',
//                                 //           companyNameController.text,
//                                 //           selectedOption!,
//                                 //           sajamCodeController.text
//                                 //               .toEnglishDigit(),
//                                 //           widget.user.tradingAccounts![0].id,
//                                 //           iban,
//                                 //           widget.user.bankAccounts![0].id,
//                                 //           nationalCodeController.text
//                                 //               .toEnglishDigit()),
//                                 //     );
//                                 //   }
//                                 // }
//                               },
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   if (state is EditProfileLoadingState) ...[
//                                     Text(
//                                       'در حال انجام',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .displaySmall,
//                                     ),
//                                     const SizedBox(
//                                       width: 6,
//                                     ),
//                                     const SizedBox(
//                                       height: 35,
//                                       child: CircularProgressIndicator(
//                                         color: AppColorScheme.scafoldCollor,
//                                       ),
//                                     ),
//                                   ] else ...[
//                                     Text(
//                                       'ویرایش',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .displaySmall,
//                                     )
//                                   ]
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
