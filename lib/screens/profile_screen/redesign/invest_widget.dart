// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:persian_number_utility/persian_number_utility.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
// import 'package:smartfunding/bloc/invites/invites_bloc.dart';
// import 'package:smartfunding/bloc/profile/profile_bloc.dart';
// import 'package:smartfunding/bloc/profile/profile_event.dart';
// import 'package:smartfunding/bloc/profile/profile_state.dart';
// import 'package:smartfunding/bloc/projects/project_bloc.dart';
// import 'package:smartfunding/bloc/projects/project_state.dart';
// import 'package:smartfunding/constant/scheme.dart';
// import 'package:smartfunding/data/model/profile/responseData.dart';
// import 'package:smartfunding/data/model/projects/Projects.dart';

// class InviteWidget extends StatefulWidget {
//   final ScrollController scrollController;
//   final ResponseData user;
//   final BuildContext context;
//   const InviteWidget(
//       {required this.scrollController,
//       required this.user,
//       required this.context,
//       super.key});

//   @override
//   State<InviteWidget> createState() => _InviteWidgetState();
// }

// class _InviteWidgetState extends State<InviteWidget> {
//   Project? filterProject;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     BlocProvider.of<InvitesBloc>(context).add(GetInvitesByProjectEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.user.user.roles!.isNotEmpty
//         ? ListView(
//             controller: widget.scrollController,
//             shrinkWrap: true,
//             children: [
//               BlocBuilder<ProjectBloc, ProjectState>(
//                 builder: (context, state) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       width: 100,
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                             width: 1,
//                             color: AppColorScheme.primaryColor,
//                           ),
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Directionality(
//                         textDirection: TextDirection.rtl,
//                         child: DropdownButtonHideUnderline(

//                             child: DropdownButton<Project>(
                              
//                           icon: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       filterProject = null;
//                                     });
//                                     BlocProvider.of<InvitesBloc>(context)
//                                         .add(GetInvitesByProjectEvent());
//                                   },
//                                   icon: const Icon(
//                                     Icons.close,
//                                     color: AppColorScheme.primaryColor,
//                                   )),
//                             ],
//                           ),
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 4, vertical: 2),
//                           isExpanded: true,
                          
//                           hint: Text('انتخاب طرح',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headlineLarge!
//                                   .copyWith(
//                                       color: Theme.of(context).primaryColor)),
                                    
//                           selectedItemBuilder: (context) {
//                             return state is ProjectResponseState
//                                 ? state.getProjects.fold(
//                                     (error) {
//                                       // Handle the error state here if needed.
//                                       return [];
//                                     },
//                                     (companyList) {
//                                       return companyList.projects
//                                           .map((company) {
//                                         return FittedBox(
//                                             fit: BoxFit.scaleDown,
//                                             child: Text(
//                                               company.title!,
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .titleSmall!
//                                                   .copyWith(
//                                                       overflow: TextOverflow
//                                                           .ellipsis),
//                                             ));
//                                       }).toList();
//                                     },
//                                   )
//                                 : [];
//                           },
//                           style: TextStyle(overflow: TextOverflow.ellipsis),
//                           items: state is ProjectResponseState
//                               ? state.getProjects.fold(
//                                   (error) {
//                                     // Handle the error state here if needed.
//                                     return [];
//                                   },
//                                   (companyList) {
//                                     return companyList.projects.map((company) {
//                                       return DropdownMenuItem<Project>(
                                        
//                                         alignment: Alignment.center,
//                                         value: company,
//                                         child: FittedBox(
//                                           fit: BoxFit.scaleDown,
//                                           child: Text(
//                                             company.title!,
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .titleSmall!
//                                                 .copyWith(
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                 ),
//                                           ),
//                                         ),
//                                         // Adjust this to your data structure.
//                                       );
//                                     }).toList();
//                                   },
//                                 )
//                               : [],
                              
//                           onChanged: (Project? newValue) {
//                             setState(() {
//                               filterProject = newValue!;
//                               BlocProvider.of<InvitesBloc>(context).add(
//                                 GetInvitesByProjectEvent(
//                                     prjectUUid: filterProject!.uuid),
//                               );
//                             });
//                           },
//                           value: filterProject,
//                         )),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               BlocBuilder<InvitesBloc, InvitesState>(
//                 builder: (context, state) {
//                   if (state is GetInvitesByProjectLoadingState) {
//                     return const Center(
//                       child: CircularProgressIndicator(
//                         color: AppColorScheme.primaryColor,
//                       ),
//                     );
//                   } else if (state is GetInvitesByProjectState) {
//                     return state.getInvites.fold((l) => Text(l), (r) {
//                       if (r.data!.isEmpty) {
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Center(
//                             child: Text('هیچ دعوتی در این طرح نداشته اید',
//                                 style: Theme.of(context).textTheme.titleSmall),
//                           ),
//                         );
//                       }
//                       return Directionality(
//                         textDirection: TextDirection.rtl,
//                         child: ListView.builder(
//                           controller: widget.scrollController,
//                           shrinkWrap: true,
//                           itemBuilder: (context, index) {
//                             final isLastIndex = index == r.data!.length - 1;
//                             bool badge = r.data![index].projects!.isNotEmpty;
//                             var invite = r.data![index];
//                             return Column(
//                               children: [
//                                 if (invite.fullName != null &&
//                                     invite.createdAt != null) ...[
//                                   ListTile(
//                                     isThreeLine: true,
//                                     leading: PhosphorIcon(
//                                         badge
//                                             ? PhosphorIconsLight.userCircleGear
//                                             : PhosphorIconsLight.userCircle,
//                                         color: AppColorScheme.primaryColor),
//                                     title: Text(
//                                       invite.fullName!,
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .labelMedium,
//                                     ),
//                                     subtitle: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const SizedBox(
//                                           height: 5,
//                                         ),
//                                         Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Text(
//                                               'وضعیت: ',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .displayLarge,
//                                             ),
//                                             Text(
//                                               badge
//                                                   ? 'سرمایه گذاری داشته'
//                                                   : 'ثبت نام کرده',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .displayLarge,
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(
//                                           height: 5,
//                                         ),
//                                         Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Text(
//                                               'تاریخ ثبت نام: ',
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .displayLarge,
//                                             ),
//                                             Text(
//                                               DateTime.parse(invite.createdAt!)
//                                                   .toPersianDateStr(),
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .displayLarge,
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(
//                                           height: 5,
//                                         ),
//                                         if (invite.projects!.isNotEmpty) ...[
//                                           Row(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               Text(
//                                                 'میزان سرمایه گذاری: ',
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .displayLarge,
//                                               ),
//                                               Text(
//                                                 '${invite.projects![0].pivot!.amount.toString().seRagham()} تومان',
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .displayLarge,
//                                               ),
//                                             ],
//                                           ),
//                                         ]
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                                 // if (!isLastIndex && user.user.invites![index].fullName !=
//                                 //         null &&
//                                 //     user.user.invites![index]
//                                 //             .createdAt !=
//                                 //         null)
//                                 //   Divider(
//                                 //     color: Colors.grey.shade200,
//                                 //   )
//                               ],
//                             );
//                           },
//                           itemCount: r.data!.length,
//                         ),
//                       );
//                     });
//                   }

//                   return const SizedBox.shrink();
//                 },
//               ),
//             ],
//           )
//         : Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: ListView.builder(
//               controller: widget.scrollController,
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 final isLastIndex =
//                     index == widget.user.user.invites!.length - 1;
//                 bool badge =
//                     widget.user.user.invites![index].project!.length > 0;
//                 return ListTile(
//                   leading: PhosphorIcon(
//                       badge
//                           ? PhosphorIconsLight.userCircleGear
//                           : PhosphorIconsLight.userCircle,
//                       color: AppColorScheme.primaryColor),
//                   title: Text(
//                     widget.user.user.invites![index].fullName ?? 'نامشخص',
//                     style: Theme.of(context).textTheme.labelMedium,
//                   ),
//                   trailing: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             'تاریخ ثبت نام: ',
//                             style: Theme.of(context).textTheme.displayLarge,
//                           ),
//                           Text(
//                             DateTime.parse(widget
//                                         .user.user.invites![index].createdAt ??
//                                     'نامشخص')
//                                 .toPersianDateStr(),
//                             style: Theme.of(context).textTheme.displayLarge,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             'وضعیت: ',
//                             style: Theme.of(context).textTheme.displayLarge,
//                           ),
//                           Text(
//                             badge ? 'سرمایه گذاری داشته' : 'ثبت نام کرده',
//                             style: Theme.of(context).textTheme.displayLarge,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               itemCount: widget.user.user.invites!.length,
//             ),
//           );
//   }
// }
