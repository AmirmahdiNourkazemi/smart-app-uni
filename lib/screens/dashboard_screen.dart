import 'dart:async';

import 'package:animated_botton_navigation/animated_botton_navigation.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smartfunding/bloc/profile/profile_bloc.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/screens/profile_screen/profile_screen.dart';
import 'package:smartfunding/utils/appbar.dart';
import 'package:smartfunding/utils/check_vpn.dart';
import 'package:smartfunding/utils/error_snack.dart';
import 'package:smartfunding/utils/success_snack.dart';

import '../bloc/auth/check_login/login_bloc.dart';
import '../bloc/get_certificate/certificate_bloc.dart';
import '../bloc/profile/profile_event.dart';
import '../bloc/projects/project_bloc.dart';
import '../bloc/transaction/transaction_bloc.dart';
import '../bloc/transaction/transaction_event.dart';
import '../utils/auth_manager.dart';
import 'auth_screen/login_screen.dart';
import 'my_assets/my_asset_screen.dart';
import 'project_screen/project_screen.dart';

class DashboardScreen extends StatefulWidget {
  final int? selected;
  const DashboardScreen({super.key, this.selected = 1});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int? _selectedIndex;
  bool? isVpnActive;
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  // final _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    // _pageController.dispose();
    _linkSubscription?.cancel();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _selectedIndex = widget.selected;
    checkVpnStatus(context);
    super.initState();
    initDeepLinks();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Listen to the app link stream
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      final link = uri.toString().toLowerCase();
      // Check for status in the link
      if (link.contains("status=1")) {
        showSuccessSnackBar(context, 'خرید با موفقیت انجام شد');
        setState(() {
          _selectedIndex = 0;
        });
      } else if (link.contains("status=0")) {
        showErrorSnackBar(context, "پرداخت با شکست مواجه شد");
      }
    }, onError: (err) {
      // Handle errors
      print('Error occurred: $err');
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _bottomBarPages = [
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProfileBloc(),
          ),
          BlocProvider(
            create: (context) => CertificateBloc(),
          ),
        ],
        child: const MyAssets(),
      ),

      BlocProvider(
        create: (context) => ProjectBloc(),
        child: ProjectScreen(),
      ),
      BlocProvider(
        create: (context) => ProfileBloc(),
        child: ProfileScreen(),
      ),

      // BlocProvider(
      //   create: (context) => ProjectBloc(),
      //   child: const TransactionScreen(),
      // ),
      // BlocProvider(
      //   create: (context) => ProjectBloc(),
      //   child: const ProfileDashboard(),
      // ),
    ];
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: ValueListenableBuilder(
        valueListenable: AuthMnager.authChangeNotifier,
        builder: (context, token, child) {
          if (token != '') {
            return buildAuth(_bottomBarPages);
          } else {
            Future.delayed(Duration.zero, () {
              return Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => CheckLoginBloc(),
                        ),
                        //  BlocProvider(create: (context) => ProjectBloc())
                      ],
                      child: const LoginScreen(),
                    );
                  },
                ),
              );
            });
            return Container();
          }
        },
      ),
    );
  }

  Widget buildAuth(List<Widget> bottonBarPages) {
    return Scaffold(
      backgroundColor: AppColorScheme.scafoldCollor,
      body: bottonBarPages[_selectedIndex!],
      appBar: _selectedIndex != 2
          ? CustomAppBar(
              backgroundColor: Colors.white,
              title: _selectedIndex == 0
                  ? 'سرمایه گذاری ها'
                  : _selectedIndex == 1
                      ? 'طرح ها'
                      : _selectedIndex == 2
                          ? 'پروفایل'
                          : '',
              textColor: Colors.black,
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex!,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        selectedLabelStyle: const TextStyle(
            fontSize: 10, fontFamily: 'IR', fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(
          fontSize: 10,
          fontFamily: 'IR',
          fontWeight: FontWeight.bold,
        ),
        showUnselectedLabels: false,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              PhosphorIconsLight.trendUp,
              color: AppColorScheme.primaryColor,
            ),
            label: 'سرمایه گذاری ها',
            activeIcon: Icon(
              PhosphorIconsFill.trendUp,
              color: AppColorScheme.primaryColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              PhosphorIconsLight.houseSimple,
              color: AppColorScheme.primaryColor,
            ),
            label: 'طرح ها',
            activeIcon: Icon(
              PhosphorIconsFill.houseSimple,
              color: AppColorScheme.primaryColor,
            ),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                PhosphorIconsLight.user,
                color: AppColorScheme.primaryColor,
              ),
              label: 'پروفایل',
              activeIcon: Icon(
                PhosphorIconsFill.user,
                color: AppColorScheme.primaryColor,
              )),
        ],
      ),
    );
  }
}
