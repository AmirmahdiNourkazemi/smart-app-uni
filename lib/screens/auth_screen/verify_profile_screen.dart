import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:smartfunding/bloc/profile/profile_event.dart';
import 'package:smartfunding/bloc/projects/project_bloc.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/utils/text_disable.dart';

import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_state.dart';
import '../dashboard_screen.dart';

class VerifyProfileScreen extends StatefulWidget {
  const VerifyProfileScreen({super.key});

  @override
  State<VerifyProfileScreen> createState() => _VerifyProfileScreenState();
}

class _VerifyProfileScreenState extends State<VerifyProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _otpControllerText = TextEditingController();

  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(ProfileStartEvent());
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animation = Tween<double>(begin: -1, end: 0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'اطلاعات حساب',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          automaticallyImplyLeading: false,
          backgroundColor: AppColorScheme.scafoldCollor,
          elevation: 0,
        ),
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      color: AppColorScheme.greyColor,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return FractionalTranslation(
                        translation: Offset(_animation.value, 0),
                        child: Container(
                          height: 8,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColorScheme.primaryColor,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoadingState) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.5),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColorScheme.primaryColor,
                      ),
                    ),
                  );
                }
                if (state is ProfileResponseState) {
                  return state.getProfile.fold(
                      (l) => Text(l),
                      (_user) => Column(
                            children: [
                              Text(
                                'تایید اطلاعات',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'شما با این مشخصات در حال ورود به اسمارت فاندینگ هستید',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade400,
                                          width: 0.4),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (_user.user.type == true &&
                                                _user.user.fullName!
                                                    .isNotEmpty) ...{
                                              disableContainer(context,
                                                  _user.user.fullName!),
                                              Text(
                                                'نام',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                            },
                                            if (_user.user.type == false &&
                                                _user.user.fullName!
                                                    .isNotEmpty) ...{
                                              disableContainer(context,
                                                  _user.user.fullName!),
                                              Text(
                                                'نام شرکت',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                            },
                                          ],
                                        ),
                                        if (_user.user.mobile.isNotEmpty) ...{
                                          const Divider(
                                              color: Colors.grey,
                                              thickness: 0.2),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                disableContainer(
                                                    context,
                                                    _user.user.mobile
                                                        .toString()
                                                        .toPersianDigit()),
                                                Text('شماره موبایل',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall),
                                              ],
                                            ),
                                          )
                                        },
                                        if (_user
                                            .user.nationalCode!.isNotEmpty) ...{
                                          const Divider(
                                              color: Colors.grey,
                                              thickness: 0.2),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                disableContainer(
                                                  context,
                                                  _user.user.nationalCode!
                                                      .toPersianDigit(),
                                                ),
                                                if (_user.user.type ==
                                                    true) ...{
                                                  Text('کدملی',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall),
                                                },
                                                if (_user.user.type ==
                                                    false) ...{
                                                  Text('شناسه ملی',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall),
                                                },
                                              ],
                                            ),
                                          ),
                                        },
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return BlocProvider(
                                      create: (context) => ProjectBloc(),
                                      child: DashboardScreen(),
                                    );
                                  }));
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          AppColorScheme.primaryColor),
                                  shape: MaterialStatePropertyAll<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  fixedSize: MaterialStatePropertyAll(
                                    Size(
                                      MediaQuery.of(context).size.width * 0.83,
                                      30,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'ورود',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                            ],
                          ));
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
