import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartfunding/bloc/auth/check_login/login_bloc.dart';
import 'package:smartfunding/bloc/projects/project_bloc.dart';
import 'package:smartfunding/di/di.dart';
import 'constant/color.dart';
import 'constant/scheme.dart';
import 'constant/text_theme.dart';
import 'firebase_options.dart';
import 'screens/auth_screen/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'utils/auth_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getItInit();
  await locator<AuthMnager>().loadRefralCode();
  await locator<AuthMnager>().loadToken();
  await locator<AuthMnager>().loadNatCode();
  await locator<AuthMnager>().loadName();
  await locator<AuthMnager>().loadRefreshToken();
  await locator<AuthMnager>().loadFingerPrint();
  await locator<AuthMnager>().loadMobile();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  bool isAuthenticated = false;
  void initState() {
    // TODO: implement initState

    isAuthenticated = AuthMnager.authChangeNotifier.value != '' &&
        AuthMnager.nameChangeNotifier.value != '';

    super.initState();
  }

  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AuthMnager.valueChangeNotifier,
      builder: (context, authValue, child) {
        // print(AuthMnager.nameChangeNotifier.value);
        // print(authValue);
        //  bool au = authValue!.isNotEmpty && AuthMnager.nameChangeNotifier.value != '' ;
        return MaterialApp(
          theme: ThemeData(
            primaryColor: AppColors.primaryColor,
            textTheme: CustomTextTheme().getTextTheme(context),
            colorScheme: AppColorScheme.appColorScheme,
            buttonTheme: const ButtonThemeData(buttonColor: Color(0xff074EA0)),
          ),
          home: authValue
              ? BlocProvider(
                  create: (context) => ProjectBloc(),
                  child: DashboardScreen(),
                )
              : BlocProvider(
                  create: (context) => CheckLoginBloc(),
                  child: const LoginScreen(
                    isBiometric: true,
                  ),
                ),
        );
      },
    );
  }
}
