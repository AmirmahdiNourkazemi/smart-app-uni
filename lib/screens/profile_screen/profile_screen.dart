import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smartfunding/screens/profile_screen/redesign/private_info_widget.dart';

import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_event.dart';
import '../../bloc/profile/profile_state.dart';

import 'redesign/address_info_widget.dart';
import 'redesign/bank_detail_widget.dart';
import 'redesign/shimmer_body.dart';
import 'redesign/sliver_app_bar_shimmer.dart';
import 'redesign/sliver_app_bar_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    BlocProvider.of<ProfileBloc>(context).add(ProfileStartEvent());
    //BlocProvider.of<HandelBloc>(context).add(HandelStartEvent());
  }

  ScrollController _scrollController = ScrollController();

  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
              return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  const SliverAppBarShimmer(),
                ];
              },
              body: const ProfileShimmerBody(),
            );
          } else if (state is ProfileResponseState) {
            return state.getProfile.fold((l) {
              return Column(
                children: [
                  Text(
                    'خطا در دریافت پروفایل',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<ProfileBloc>(context)
                            .add(ProfileStartEvent());
                      },
                      child: Text(
                        'تلاش مجدد',
                        style: Theme.of(context).textTheme.titleLarge,
                      ))
                ],
              );
            },
                (r) => NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return [
                          SliverAppBarWidget(
                            r: r,
                          )
                        ];
                      },
                      body: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: ListView(
                          children: [
                            PrivateinfoWidget(r: r),
                            const SizedBox(
                              height: 10,
                            ),
                            
                          ],
                        ),
                      ),
                    ));
          } else {
            return Container();
          }
        },
      )),
    );
  }
}
