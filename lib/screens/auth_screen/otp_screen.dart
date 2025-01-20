// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:otp_timer_button/otp_timer_button.dart';
// import 'package:persian_number_utility/persian_number_utility.dart';
// import 'package:pinput/pinput.dart';
// import 'package:smartfunding/bloc/auth/check_login/login_bloc.dart';
// import 'package:smartfunding/bloc/auth/edit_profile/edit_profile_bloc.dart';
// import 'package:smartfunding/screens/auth_screen/login_screen.dart';
// import 'package:smartfunding/screens/sign_up/sign_up_screen.dart';
// import '../../bloc/auth/check_otp_verify/otp_verify_bloc.dart';
// import '../../bloc/auth/check_otp_verify/otp_verify_event.dart';
// import '../../bloc/auth/check_otp_verify/otp_verify_state.dart';
// import '../../bloc/profile/profile_bloc.dart';
// import '../../constant/scheme.dart';
// import '../../utils/error_snack.dart';
// import 'verify_profile_screen.dart';

// class OtpScreen extends StatefulWidget {
//   final String mobile;
//   final String nationalCode;
//   const OtpScreen({
//     super.key,
//     required this.nationalCode,
//     required this.mobile,
//   });

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// bool isChecked = false;

// class _OtpScreenState extends State<OtpScreen>
//     with SingleTickerProviderStateMixin {
//   @override
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _otpControllerText = TextEditingController();

//   void initState() {
//     super.initState();
//     BlocProvider.of<OtpVerifyBloc>(context).add(OtpVerifyInitEvent());
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 400),
//     );

//     _animation = Tween<double>(begin: -1, end: 0).animate(_controller);

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<OtpVerifyBloc, OtpVerifyState>(
//       listener: (context, state) {
//         if (state is OtpVerifyResponse) {
//           state.getcheckOtp.fold(
//             (l) {
//               //  Navigator.of(context).pop();
//               // context.pushReplacementNamed(RouteNames.main);
//               showErrorSnackBar(context, l);
//             },
//             (r) {
//               if (r == 'ورود') {
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (context) {
//                   return BlocProvider(
//                     create: (context) => ProfileBloc(),
//                     child: const VerifyProfileScreen(),
//                   );
//                 }));
//               } else {
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (context) {
//                   return BlocProvider(
//                     create: (context) => EditProfileBloc(),
//                     child: SignUpScreen(),
//                   );
//                 }));
//               }
//             },
//           );
//         }
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text(
//             'ورود رمز پیامکی',
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//           automaticallyImplyLeading: false,
//           backgroundColor: AppColorScheme.scafoldCollor,
//           elevation: 0,
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Hero(
//               tag: '1',
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 8,
//                     width: 70,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: AppColorScheme.greyColor,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 4,
//                   ),
//                   AnimatedBuilder(
//                     animation: _controller,
//                     builder: (context, child) {
//                       return FractionalTranslation(
//                         translation: Offset(_animation.value, 0),
//                         child: Container(
//                           height: 8,
//                           width: 70,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: AppColorScheme.primaryColor,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(
//                     width: 4,
//                   ),
//                   Container(
//                     height: 8,
//                     width: 70,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: AppColorScheme.greyColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Column(
//               children: [
//                 Text(
//                   'ورود کد تایید',
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   'کد پیامک شده به موبایل متعلق به کدملی زیر را وارد کنید',
//                   style: Theme.of(context).textTheme.headlineSmall,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   widget.nationalCode.toPersianDigit(),
//                   style: Theme.of(context).textTheme.headlineSmall,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Form(
//                   key: _formKey,
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.75,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 10),
//                       child: Center(
//                         child: Pinput(
//                           length: 5,
//                           errorTextStyle: const TextStyle(
//                             fontSize: 12,
//                             color: Colors.red,
//                           ),
//                           defaultPinTheme: PinTheme(
//                             width: 50,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               color: Colors.blueAccent.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                           controller: _otpControllerText,
//                           keyboardType: TextInputType.number,
//                           closeKeyboardWhenCompleted: true,
//                           errorPinTheme: PinTheme(
//                             width: 50,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               color: Colors.red.withOpacity(0.3),
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                           androidSmsAutofillMethod:
//                               AndroidSmsAutofillMethod.smsUserConsentApi,
//                           onCompleted: (value) {
//                             _otpControllerText.text = value.toEnglishDigit();
//                             BlocProvider.of<OtpVerifyBloc>(context).add(
//                               OtpVerifyButtonClick(
//                                 widget.mobile,
//                                 widget.nationalCode,
//                                 _otpControllerText.text.toEnglishDigit(),
//                               ),
//                             );
//                           },
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'لطفا کد را وارد کنید';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 BlocBuilder<OtpVerifyBloc, OtpVerifyState>(
//                   builder: (context, state) {
//                     return ElevatedButton(
//                         style: ButtonStyle(
//                             backgroundColor: MaterialStatePropertyAll(
//                                 state is OtpVerifyLoadingState
//                                     ? Colors.grey
//                                     : AppColorScheme.primaryColor),
//                             shape: MaterialStatePropertyAll<
//                                 RoundedRectangleBorder>(RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             )),
//                             fixedSize: MaterialStatePropertyAll(Size(
//                                 MediaQuery.of(context).size.width * 0.75, 30))),
//                         onPressed: () {
//                           BlocProvider.of<OtpVerifyBloc>(context).add(
//                             OtpVerifyButtonClick(
//                               widget.mobile,
//                               widget.nationalCode,
//                               _otpControllerText.text.toEnglishDigit(),
//                             ),
//                           );
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             if (state is OtpVerifyLoadingState) ...[
//                               const CircularProgressIndicator(
//                                 color: AppColorScheme.scafoldCollor,
//                               ),
//                               const SizedBox(
//                                 width: 4,
//                               ),
//                               Text(
//                                 'در حال انجام',
//                                 style: Theme.of(context).textTheme.displaySmall,
//                               ),
//                             ] else ...[
//                               Text(
//                                 'تایید',
//                                 style: Theme.of(context).textTheme.displaySmall,
//                               ),
//                             ]
//                           ],
//                         ));
//                   },
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     OtpTimerButton(
//                       //controller: controller,
//                       height: 60,
//                       text: Text(
//                         'ارسال مجدد کد',
//                         style: Theme.of(context).textTheme.bodySmall,
//                       ),
//                       duration: 30,
//                       radius: 30,
//                       backgroundColor: AppColorScheme.primaryColor,
//                       textColor: Colors.white,
//                       buttonType: ButtonType
//                           .text_button, // or ButtonType.outlined_button
//                       loadingIndicator: const CircularProgressIndicator(
//                         strokeWidth: 2,
//                         color: Colors.red,
//                       ),
//                       loadingIndicatorColor: Colors.red,
//                       onPressed: () {
//                         Navigator.of(context).pushReplacement(
//                           MaterialPageRoute(
//                             builder: (context) {
//                               return BlocProvider(
//                                 create: (context) => CheckLoginBloc(),
//                                 child: LoginScreen(),
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
