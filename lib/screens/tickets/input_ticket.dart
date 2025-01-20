import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smartfunding/bloc/ticket/create_ticket/create_ticket_bloc.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/utils/error_snack.dart';
import 'package:smartfunding/utils/success_snack.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../bloc/ticket/create_ticket/create_ticket_state.dart';
import '../../../bloc/ticket/get_Ticket/ticket_bloc.dart';
import '../../../bloc/ticket/get_Ticket/ticket_event.dart';
import '../../bloc/ticket/create_ticket/create_ticket_event.dart';
import 'message_box.dart';

class InputTicket extends StatefulWidget {
  int? type;
  InputTicket({super.key, this.type});

  @override
  State<InputTicket> createState() => _InputTicketState();
}

class _InputTicketState extends State<InputTicket> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    await launch(url);
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  int? selectedValue;
  List<DropdownMenuItem<int>> get dropdownItems {
    List<DropdownMenuItem<int>> menuItems = [
      const DropdownMenuItem(
          value: 1,
          child: Text(
            "پشتیبانی فنی",
            style: TextStyle(fontFamily: 'IR', fontSize: 12),
          )),
      const DropdownMenuItem(
        value: 2,
        child: Text(
          "پشتیبانی فروش",
          style: TextStyle(fontFamily: 'IR', fontSize: 12),
        ),
      ),
      const DropdownMenuItem(
        value: 3,
        child: Text(
          "ثبت تخلف",
          style: TextStyle(fontFamily: 'IR', fontSize: 12),
        ),
      ),
    ];
    return menuItems;
  }

  @override
  void initState() {
    BlocProvider.of<CreateTicketBloc>(context).add(CreateTicketStartEvent());
    selectedValue = widget.type ?? 1;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(
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
          return false;
        },
        child: Scaffold(
          // floatingActionButton: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: FloatingActionButton(
          //     onPressed: () {
          //       _makePhoneCall('02166010735');
          //     },
          //     //isExtended: true,
          //     heroTag: '2',
          //     tooltip: 'تماس با پشتیبانی',
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: const Icon(Icons.call),
          //   ),
          // ),
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColorScheme.primaryColor,
          appBar: AppBar(
            elevation: 0.0,

            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(
              'پشتیبانی',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            leading: IconButton(
              onPressed: () {
                // context.read<TicketBloc>().add(TicketStartEvent());
                // Navigator.of(context).pop();
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
              icon: const PhosphorIcon(
                PhosphorIconsRegular.arrowLeft,
              ),
            ),
            // actions: [
            //   IconButton(
            //     onPressed: () {
            //       context.goNamed(RouteNames.message);
            //     },
            //     icon: PhosphorIcon(PhosphorIcons.arrowRight()),
            //     color: Colors.white,
            //   )
            // ],
          ),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: BlocListener<CreateTicketBloc, CreateTicketState>(
                listener: (context, state) {
                  if (state is CreateTicketResponseState) {
                    state.response.fold(
                      (l) {
                        showErrorSnackBar(context, l);
                      },
                      (r) {
                        titleController.clear();
                        descriptionController.clear();

                        Navigator.of(context).pushReplacement(
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

                        showSuccessSnackBar(
                            context, 'تیکت شما با موفقیت ثبت شد');
                      },
                    );
                  }
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      // height: Responsive.isDesktop(context) ? 380 : 400,
                      // width: Responsive.isDesktop(context)
                      //     ? 600
                      //     : MediaQuery.of(context).size.width * 0.9,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          shrinkWrap: true,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'برای ثبت تیکت موارد زیر را پر کنید',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: titleController,
                              style: const TextStyle(
                                  fontSize: 12, fontFamily: 'IR'),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                labelText: 'تیتر',
                                labelStyle: const TextStyle(
                                    fontSize: 12, fontFamily: 'IR'),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColorScheme.primaryColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'لطفا تیتر را پر کنید';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: descriptionController,
                              maxLines: null,
                              style: const TextStyle(
                                fontFamily: 'IR',
                                fontSize: 12,
                              ),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                labelText: 'توضیحات',
                                labelStyle: const TextStyle(
                                  fontFamily: 'IR',
                                  fontSize: 12,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColorScheme.primaryColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'لطفا توضیحات را پر کنید';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                hintText: 'انتخاب دسته بندی',
                                labelStyle: const TextStyle(fontFamily: 'IR'),
                                hintStyle: const TextStyle(fontFamily: 'IR'),
                                helperStyle: const TextStyle(fontFamily: 'IR'),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColorScheme.primaryColor,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColorScheme.primaryColor,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                //filled: true,
                                //fillColor: Colors.blueAccent,
                              ),
                              dropdownColor: Colors.white,
                              items: dropdownItems,
                              elevation: 4,
                              onChanged: (int? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                });
                              },
                              // validator: (value) {
                              //   if () {

                              //   }
                              // },
                              value: selectedValue,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColorScheme.primaryColor,
                                    fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.83,
                                      50,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // print(selectedValue);
                                      BlocProvider.of<CreateTicketBloc>(context)
                                          .add(
                                        CreateTicketClickedEvent(
                                          titleController.text,
                                          descriptionController.text,
                                          selectedValue!,
                                        ),
                                      );
                                    }
                                  },
                                  child: BlocBuilder<CreateTicketBloc,
                                      CreateTicketState>(
                                    builder: (context, state) {
                                      if (state is CreateTicketLoadingState) {
                                        return const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'در حال ثبت',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'IR',
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          ],
                                        );
                                      } else {
                                        return const Text(
                                          'ثبت تیکت',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'IR',
                                              color: Colors.white),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
