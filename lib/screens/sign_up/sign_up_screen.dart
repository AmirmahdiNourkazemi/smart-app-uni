import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:smartfunding/bloc/auth/edit_profile/edit_profile_bloc.dart';
import 'package:smartfunding/bloc/auth/edit_profile/edit_profile_event.dart';
import 'package:smartfunding/bloc/auth/edit_profile/edit_profile_state.dart';
import 'package:smartfunding/bloc/projects/project_bloc.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/screens/dashboard_screen.dart';
import 'package:smartfunding/utils/auth_manager.dart';
import 'package:smartfunding/utils/error_snack.dart';
import 'package:smartfunding/utils/success_snack.dart';

import '../../utils/money_seprator_ir.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nationalCodeController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  int selectedOption = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileResponseState) {
          state.editProfile.fold(
            (l) => showErrorSnackBar(context, l),
            (r) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return BlocProvider(
                    create: (context) => ProjectBloc(),
                    child: DashboardScreen(),
                  );
                },
              ),
            ),
          );
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Colors.white,
            title: const Text(
              'ثبت نام',
              style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'IR',
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('شخص حقیقی یا حقوقی هستید؟'),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              titleAlignment:
                                  ListTileTitleAlignment.titleHeight,
                              leadingAndTrailingTextStyle:
                                  Theme.of(context).textTheme.titleMedium,
                              title: const Text('حقیقی'),
                              titleTextStyle:
                                  Theme.of(context).textTheme.titleMedium,
                              leading: Radio<int>(
                                value: 1,
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption = value!;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('حقوقی'),
                              contentPadding: EdgeInsets.zero,
                              titleTextStyle:
                                  Theme.of(context).textTheme.titleMedium,
                              titleAlignment:
                                  ListTileTitleAlignment.titleHeight,
                              leading: Radio<int>(
                                value: 2,
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          cursorHeight: 19,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
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
                            labelText: selectedOption == 1 ? 'نام' : 'نام شرکت',
                            labelStyle: Theme.of(context).textTheme.titleMedium,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                color: AppColorScheme.primaryColor,
                                width: 0.5,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (selectedOption == 1 && value!.isEmpty) {
                              return 'نام را وارد کنید';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          cursorHeight: 19,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                          keyboardType: TextInputType.text,
                          controller: mobileController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
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
                            labelStyle: Theme.of(context).textTheme.titleMedium,
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          cursorHeight: 19,
                          style: Theme.of(context).textTheme.titleMedium,
                          keyboardType: TextInputType.number,
                          controller: nationalCodeController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
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
                            labelText:
                                selectedOption == 1 ? 'کدملی' : 'شناسه ملی',
                            labelStyle: Theme.of(context).textTheme.titleMedium,
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
                              return 'کدملی یا شناسه ملی را وارد کنید';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: BlocBuilder<EditProfileBloc, EditProfileState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    state is EditProfileLoadingState
                                        ? Colors.grey
                                        : AppColorScheme.primaryColor),
                                shape: MaterialStatePropertyAll<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (selectedOption == 1) {
                                    BlocProvider.of<EditProfileBloc>(context)
                                        .add(
                                      EditProfileButtonClickEvent(
                                        name: nameController.text,
                                        type: selectedOption,
                                        nationalCode:
                                            nationalCodeController.text,
                                        mobile: mobileController.text,
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (state is EditProfileLoadingState) ...[
                                    Text(
                                      'در حال انجام',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    const SizedBox(
                                      height: 35,
                                      child: CircularProgressIndicator(
                                        color: AppColorScheme.scafoldCollor,
                                      ),
                                    ),
                                  ] else ...[
                                    Text(
                                      'ثبت نام',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    )
                                  ]
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
