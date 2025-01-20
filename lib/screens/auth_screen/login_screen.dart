import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smartfunding/bloc/auth/check_otp_verify/otp_verify_bloc.dart';
import 'package:smartfunding/bloc/projects/project_bloc.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/screens/auth_screen/otp_screen.dart';
import 'package:smartfunding/screens/dashboard_screen.dart';
import 'package:smartfunding/screens/sign_up/sign_up_screen.dart';
import 'package:smartfunding/utils/auth_manager.dart';
import 'package:smartfunding/utils/check_vpn.dart';
import 'package:smartfunding/utils/error_snack.dart';
import 'package:smartfunding/utils/finger_print_ability.dart';
import 'package:smartfunding/utils/show_faraborse_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/auth/check_login/login_bloc.dart';
import '../../bloc/auth/check_login/login_event.dart';
import '../../bloc/auth/check_login/login_state.dart';
import '../../bloc/auth/edit_profile/edit_profile_bloc.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../utils/finger_print_ability copy.dart';
import 'verify_profile_screen.dart';

class LoginScreen extends StatefulWidget {
  final bool? isBiometric;
  const LoginScreen({super.key, this.isBiometric = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool? isVpnActive;

// final _formKey = GlobalKey<FormState>();
final LocalAuthentication auth = LocalAuthentication();

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final TextEditingController nationalCodeController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  Future<void> _localAuth() async {
    bool support = await BiometricUtils.checkBiometricSupport();
    print('isBiometricSupport $support');
    if (support && mounted) {
      try {
        final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'برای ورود میتوانید با اثر انگشت وارد شوید',
          options: const AuthenticationOptions(
              biometricOnly: true, stickyAuth: true),
        );
        if (didAuthenticate && mounted) {
          BlocProvider.of<CheckLoginBloc>(context).add(
            CheckLoginButtonClick(
                AuthMnager.mobileChangeNotifier.value!.toEnglishDigit(),
                AuthMnager.nationalChangeNotifier.value!.toEnglishDigit(),
                null),
          );
        }
      } on PlatformException catch (e) {
        if (mounted) {
          print(e);
        }
      }
    } else {
      if (mounted) {
        print('No biometric features available on this device.');
      }
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    checkVpnStatus(context);
    print(AuthMnager.nationalChangeNotifier.value);
    print(AuthMnager.mobileChangeNotifier.value);

    if (widget.isBiometric == true) {
      _localAuth();
    }
    BlocProvider.of<CheckLoginBloc>(context).add(CheckLoginInitEvent());
  }

  @override
  void dispose() {
    nationalCodeController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckLoginBloc, CheckLoginState>(
      listener: (context, state) {
        if (state is CheckLoginResponse) {
          state.getCheck.fold(
            (l) {
              print(l);
              if (l == '420') {
                showFaraborseDialog(context);
              } else {
                showErrorSnackBar(context, l);
              }
            },
            (r) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return BlocProvider(
                  create: (context) => ProfileBloc(),
                  child: const VerifyProfileScreen(),
                );
              }));
            },
          );
        }
        if (state is LoginWithFingerPrintState) {
          state.getCheck.fold((l) => showErrorSnackBar(context, l), (r) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return BlocProvider(
                    create: (context) => ProjectBloc(),
                    child: const DashboardScreen(),
                  );
                },
              ),
            );
          });
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColorScheme.scafoldCollor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'ورود به حساب',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            backgroundColor: AppColorScheme.scafoldCollor,
            elevation: 0,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: '1',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 8,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColorScheme.primaryColor),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Container(
                      height: 8,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColorScheme.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Column(
                  children: [
                    Text(
                      'لطفا موارد زیر را تکمیل کنید',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'باید قبلا در سامانه سجام ثبت نام شده باشد',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Form(
                        key: _formKey1,
                        child: Column(
                          children: [
                            TextFormField(
                              cursorHeight: 19,
                              style: const TextStyle(
                                  fontSize: 12, fontFamily: 'IR'),
                              keyboardType: TextInputType.number,
                              controller: mobileController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                ),
                                labelText: 'شماره موبایل',
                                labelStyle:
                                    Theme.of(context).textTheme.labelMedium,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: const BorderSide(
                                    color: AppColorScheme.primaryColor,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'شماره موبایل را وارد کنید';
                                }
                                return null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                cursorHeight: 19,
                                style: const TextStyle(
                                    fontSize: 12, fontFamily: 'IR'),
                                keyboardType: TextInputType.number,
                                controller: nationalCodeController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(7),
                                    ),
                                  ),
                                  labelText: 'شماره ملی / کد ملی',
                                  labelStyle:
                                      Theme.of(context).textTheme.labelMedium,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: const BorderSide(
                                      color: AppColorScheme.primaryColor,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'کدملی را وارد کنید';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<CheckLoginBloc, CheckLoginState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  state is CheckLoadingState
                                      ? Colors.grey
                                      : AppColorScheme.primaryColor),
                              shape: MaterialStatePropertyAll<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                              fixedSize: MaterialStatePropertyAll(Size(
                                  MediaQuery.of(context).size.width * 0.75,
                                  30))),
                          onPressed: () async {
                            if (_formKey1.currentState!.validate()) {
                              BlocProvider.of<CheckLoginBloc>(context).add(
                                CheckLoginButtonClick(
                                    mobileController.text.toEnglishDigit(),
                                    nationalCodeController.text
                                        .toEnglishDigit(),
                                    null),
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (state is CheckLoadingState) ...[
                                const SizedBox(
                                  height: 35,
                                  child: CircularProgressIndicator(
                                    color: AppColorScheme.scafoldCollor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  'در حال انجام',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ] else ...[
                                Text(
                                  'ورود',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                )
                              ]
                            ],
                          ),
                        );
                      },
                    ),
                    if (AuthMnager.nationalChangeNotifier.value != '' &&
                        AuthMnager.mobileChangeNotifier.value != '') ...[
                      ValueListenableBuilder(
                        valueListenable: AuthMnager.isFingerPrint,
                        builder: (context, value, child) {
                          return Visibility(
                              visible: value,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: OutlinedButton.icon(
                                  style: ButtonStyle(
                                      side: WidgetStatePropertyAll(
                                        BorderSide(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      shape: WidgetStatePropertyAll<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                      fixedSize: WidgetStatePropertyAll(Size(
                                          MediaQuery.of(context).size.width *
                                              0.75,
                                          30))),
                                  onPressed: _localAuth,
                                  label: Text('ورود با اثرانگشت',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                  icon:
                                      const Icon(PhosphorIconsBold.fingerprint),
                                ),
                              ));
                        },
                      ),
                    ],
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return BlocProvider(
                              create: (context) => EditProfileBloc(),
                              child: SignUpScreen(),
                            );
                          }));
                        },
                        child: Text(
                          'ثبت نام نکرده اید؟؟',
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await launch(
                                'https://profilesejam.csdiran.ir/session');
                          },
                          child: Text(
                            'ثبت نام در سجام',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          'در سامانه سجام ثبت نام نکرده اید؟',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: TextButton(
                    onPressed: () async {
                      await launch('https://smartfunding.ir/terms/');
                    },
                    child: Text(
                      'شرایط و قوانین',
                      style: Theme.of(context).textTheme.bodySmall,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
