import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfunding/bloc/auth/check_otp_verify/otp_verify_bloc.dart';
import 'package:smartfunding/bloc/auth/check_otp_verify/otp_verify_event.dart';
import 'package:smartfunding/bloc/auth/check_otp_verify/otp_verify_state.dart';
import 'package:smartfunding/bloc/projects/project_bloc.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/di/di.dart';
import 'package:smartfunding/screens/dashboard_screen.dart';
import 'package:smartfunding/utils/auth_manager.dart';
import 'package:smartfunding/utils/error_snack.dart';

class OtpForceUpdateScreen extends StatefulWidget {
  final String nationalCode;
  final String mobile;
  const OtpForceUpdateScreen(
      {required this.mobile, required this.nationalCode, super.key});

  @override
  State<OtpForceUpdateScreen> createState() => _OtpForceUpdateScreenState();
}

class _OtpForceUpdateScreenState extends State<OtpForceUpdateScreen> {
  bool isChecked = false;
  @override
  TextEditingController _otpControllerText = TextEditingController();
  late AnimationController _controller;
  final _formKey = GlobalKey<FormState>();
  final SharedPreferences _sharedPreferences = locator.get();
  @override
  void initState() {
    BlocProvider.of<OtpVerifyBloc>(context).add(OtpVerifyInitEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpVerifyBloc, OtpVerifyState>(
      listener: (context, state) {
        if (state is OtpVerifyResponse) {
          state.getcheckOtp.fold(
            (l) {
              showErrorSnackBar(context, l);
            },
            (r) {
              if (r == 'ورود') {
                return Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return BlocProvider(
                    create: (context) => ProjectBloc(),
                    child: const DashboardScreen(
                      selected: 2,
                    ),
                  );
                }));
              }
            },
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColorScheme.primaryColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'ورود رمز پیامکی',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          automaticallyImplyLeading: true,
          backgroundColor: AppColorScheme.scafoldCollor,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const PhosphorIcon(PhosphorIconsRegular.arrowLeft)),
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'ورود کد تایید',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'کد پیامک شده به موبایل متعلق به کدملی زیر را وارد کنید',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.nationalCode.toPersianDigit(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Center(
                        child: Pinput(
                          length: 5,
                          errorTextStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                          ),
                          defaultPinTheme: PinTheme(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          controller: _otpControllerText,
                          keyboardType: TextInputType.number,
                          closeKeyboardWhenCompleted: true,
                          errorPinTheme: PinTheme(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsUserConsentApi,
                          onCompleted: (value) {
                            _otpControllerText.text = value.toEnglishDigit();
                            BlocProvider.of<OtpVerifyBloc>(context).add(
                              OtpVerifyButtonClick(
                                widget.mobile,
                                widget.nationalCode,
                                _otpControllerText.text.toEnglishDigit(),
                                forceUpdate: true,
                              ),
                            );
                            locator<AuthMnager>()
                                .saveForceUpdateDate(DateTime.now().toString());
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'لطفا کد را وارد کنید';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<OtpVerifyBloc, OtpVerifyState>(
                  builder: (context, state) {
                    return ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                state is OtpVerifyLoadingState
                                    ? Colors.grey
                                    : AppColorScheme.primaryColor),
                            shape: MaterialStatePropertyAll<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                            fixedSize: MaterialStatePropertyAll(Size(
                                MediaQuery.of(context).size.width * 0.75, 30))),
                        onPressed: () {
                          BlocProvider.of<OtpVerifyBloc>(context).add(
                            OtpVerifyButtonClick(
                                widget.mobile,
                                widget.nationalCode,
                                _otpControllerText.text.toEnglishDigit(),
                                forceUpdate: true),
                          );
                          locator<AuthMnager>()
                              .saveForceUpdateDate(DateTime.now().toString());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (state is OtpVerifyLoadingState) ...[
                              const CircularProgressIndicator(
                                color: AppColorScheme.scafoldCollor,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                'در حال انجام',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ] else ...[
                              Text(
                                'تایید',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ]
                          ],
                        ));
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OtpTimerButton(
                      //controller: controller,
                      height: 60,
                      text: Text(
                        'ارسال مجدد کد',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      duration: 30,
                      radius: 30,
                      backgroundColor: AppColorScheme.primaryColor,
                      textColor: Colors.white,
                      buttonType: ButtonType
                          .text_button, // or ButtonType.outlined_button
                      loadingIndicator: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.red,
                      ),
                      loadingIndicatorColor: Colors.red,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
