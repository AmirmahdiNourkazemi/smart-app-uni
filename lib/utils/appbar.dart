import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartfunding/bloc/profile/profile_bloc.dart';
import 'package:smartfunding/bloc/profile/profile_event.dart';
import 'package:smartfunding/bloc/profile/profile_state.dart';
import 'package:smartfunding/bloc/ticket/get_Ticket/ticket_event.dart';

import 'package:smartfunding/screens/tickets/message_box.dart';

import '../bloc/ticket/get_Ticket/ticket_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? backgroundColor;
  final Color? textColor;
  final Key? key;

  const CustomAppBar({
    this.key,
    this.title,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      //elevation: 0.7,
      // foregroundColor: AppColorScheme.primaryColor,
      backgroundColor: backgroundColor,
      title: title != null
          ? Text(
              title!,
              style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'IR',
                  fontWeight: FontWeight.w400,
                  color: textColor),
            )
          : null,

      actions: [
        BlocProvider(
          create: (context) {
            ProfileBloc _bloc = ProfileBloc();
            _bloc.add(ProfileStartEvent());
            return _bloc;
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileResponseState) {
                return state.getProfile.fold(
                    (l) => Container(),
                    (r) => Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextButton.icon(
                              style: ButtonStyle(
                                  textStyle:
                                      MaterialStatePropertyAll<TextStyle>(
                                          TextStyle(color: textColor))),
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
                              label: Text(
                                'پشتیبانی',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'IR',
                                    fontWeight: FontWeight.w400,
                                    color: textColor),
                              ),
                              icon: Image.asset(
                                'assets/images/support.png',
                                width: 23,
                              )),
                        ));
              } else {
                return Container();
              }
            },
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
