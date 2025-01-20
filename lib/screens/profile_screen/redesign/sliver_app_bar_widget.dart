import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smartfunding/bloc/auth/check_login/login_bloc.dart';
import 'package:smartfunding/bloc/profile/profile_bloc.dart';
import 'package:smartfunding/bloc/profile/profile_event.dart';
import 'package:smartfunding/bloc/ticket/get_Ticket/ticket_bloc.dart';
import 'package:smartfunding/bloc/ticket/get_Ticket/ticket_event.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/data/model/profile/responseData.dart';
import 'package:smartfunding/di/di.dart';
import 'package:smartfunding/screens/auth_screen/login_screen.dart';
import 'package:smartfunding/screens/tickets/message_box.dart';
import 'package:smartfunding/utils/auth_manager.dart';
import 'package:smartfunding/utils/finger_print_ability%20copy.dart';

import 'share_button_sheet.dart';

class SliverAppBarWidget extends StatefulWidget {
  final ResponseData r;
  const SliverAppBarWidget({
    required this.r,
    super.key,
  });

  @override
  State<SliverAppBarWidget> createState() => _SliverAppBarWidgetState();
}

class _SliverAppBarWidgetState extends State<SliverAppBarWidget> {
  bool isBiometricSupport = false;
  void _checkBiometricSupport() async {
    bool support = await BiometricUtils.checkBiometricSupport();
    setState(() {
      isBiometricSupport = support;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _checkBiometricSupport();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      excludeHeaderSemantics: true,
      titleSpacing: 0,
      stretchTriggerOffset: 140,
      bottom: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 70,
            height: 8,
            decoration: BoxDecoration(
                border:
                    Border.all(color: AppColorScheme.primaryColor, width: 0.5),
                borderRadius: BorderRadius.circular(50),
                color: Colors.white),
          ),
        ),
      ),
      elevation: 3,
      pinned: true,
      shadowColor: Theme.of(context).colorScheme.primary,
      expandedHeight: 300,
      automaticallyImplyLeading: false,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: AppColorScheme.primaryColor),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      scrolledUnderElevation: 20,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: AppColorScheme.scafoldCollor,
                        child: Icon(
                          PhosphorIconsLight.user,
                          color: Theme.of(context).colorScheme.primary,
                          size: 32,
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: AppColorScheme.primaryColor,
                                    width: 0.5),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                PhosphorIconsLight.pencilSimple,
                                color: AppColorScheme.primaryColor,
                                size: 20,
                              ),
                            )),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'نام کابری: ${widget.r.user.fullName!} ',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'شماره موبایل: ${widget.r.user.mobile} ',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isBiometricSupport
                      ? Colors.white
                      : const Color.fromARGB(255, 218, 218, 218),
                ),
                height: 40,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  AppColorScheme.primaryColor.withOpacity(0.2),
                            ),
                            child: Icon(PhosphorIconsLight.fingerprint,
                                color: Theme.of(context).primaryColor),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text('ورود با اثر انگشت',
                              style: Theme.of(context).textTheme.titleSmall),
                        ],
                      ),
                    ),
                    IgnorePointer(
                      ignoring: !isBiometricSupport,
                      child: Transform.scale(
                          scale: 0.8,
                          child: ValueListenableBuilder(
                            valueListenable: AuthMnager.isFingerPrint,
                            builder: (context, value, child) {
                              return Switch(
                                  value: value,
                                  onChanged: (value) async {
                                    await locator<AuthMnager>()
                                        .saveFingerPrint(value);
                                  });
                            },
                          )),
                    )
                  ],
                )),
              ),
              const SizedBox(
                height: 4,
              ),
              InkWell(
                onTap: () => showCustomBottomSheet(widget.r, context),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  height: 40,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                color: AppColorScheme.primaryColor
                                    .withOpacity(0.2),
                              ),
                              child: Icon(PhosphorIconsLight.shareNetwork,
                                  color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text('دعوت از دوستان',
                                style: Theme.of(context).textTheme.titleSmall),
                          ],
                        ),
                        Icon(
                          PhosphorIconsLight.caretRight,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  )),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      leadingWidth: 110,
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: OutlinedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).scaffoldBackgroundColor,
              ),
              side: WidgetStatePropertyAll(
                BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              fixedSize:
                  const WidgetStatePropertyAll(Size(double.infinity, 40)),
              shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
            ),
            onPressed: () {
              AuthMnager.logout();

              BlocProvider.of<ProfileBloc>(context).add(ProfileLogoutEvent());

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => CheckLoginBloc(),
                      child: LoginScreen(),
                    );
                  },
                ),
              );
            },
            child: Text('خروج',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Theme.of(context).primaryColor)),
          ),
        )
      ],
      leading: TextButton.icon(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return MultiBlocProvider(providers: [
                  BlocProvider(
                    create: (context) {
                      TicketBloc bloc = TicketBloc();
                      bloc.add(TicketStartEvent());
                      return bloc;
                    },
                  ),
                ], child: const MessageBox());
              },
            ),
          );
        },
        icon: const Icon(PhosphorIconsLight.question),
        label: Text(
          'پشتیبانی',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
      centerTitle: true,
    );
  }
}
