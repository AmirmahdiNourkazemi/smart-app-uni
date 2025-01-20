import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/screens/auth_screen/login_screen.dart';
import 'package:smartfunding/utils/auth_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../bloc/ticket/create_ticket/create_ticket_bloc.dart';
import '../../../bloc/ticket/get_Ticket/ticket_bloc.dart';
import '../../../bloc/ticket/get_Ticket/ticket_event.dart';
import '../../../bloc/ticket/get_Ticket/ticket_state.dart';
import '../../../data/model/tickets/ticket.dart';
import '../../bloc/auth/check_login/login_bloc.dart';
import '../../bloc/projects/project_bloc.dart';
import '../../di/di.dart';
import '../dashboard_screen.dart';
import 'chat_box.dart';
import 'input_ticket.dart';

class MessageBox extends StatefulWidget {
  const MessageBox({Key? key}) : super(key: key);

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Future<void> _makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    await launch(url);
  }

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<TicketBloc>(context).add(TicketStartEvent());
  }

  int selectedValue = 5;
  int selectedChangeStatusValue = 1;
  List<DropdownMenuItem<int>> get dropdownItems {
    List<DropdownMenuItem<int>> menuItems = [
      DropdownMenuItem(value: 3, child: Text("3".toPersianDigit())),
      DropdownMenuItem(value: 5, child: Text("5".toPersianDigit())),
    ];
    return menuItems;
  }

  List<Ticket> sortedTickets = [];
  void _sortTickets(List<Ticket> tickets) {
    sortedTickets = tickets;
    sortedTickets.sort((a, b) {
      if (a.status == b.status) return 0;
      if (a.status == 1) return -1;
      if (b.status == 1) return 1;
      if (a.status == 2) return -1;
      if (b.status == 2) return 1;
      return 0;
    });
    Future.microtask(() {
      if (mounted) {
        setState(() {
          sortedTickets = tickets;
        });
      }
    });
  }

  Future<void> _showConfirmationBottomSheet(String ticketUuid) async {
    bool? confirm = await showModalBottomSheet<bool>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'آیا مطمئن هستید که می‌خواهید تیکت را ببندید؟',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'IR',
                    fontSize: 12,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: AppColorScheme.primaryColor,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          "خیر",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColorScheme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: AppColorScheme.primaryColor,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text(
                          "بله",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

    if (confirm == true) {
      BlocProvider.of<TicketBloc>(context).add(CloseTicketEvent(ticketUuid));
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => ProjectBloc(),
                child: DashboardScreen(),
              );
            },
          ),
        );
        return false;
      },
      child: RefreshIndicator(
        displacement: 60,
        onRefresh: () async {
          BlocProvider.of<TicketBloc>(context).add(TicketStartEvent());
        },
        child: ValueListenableBuilder(
            valueListenable: AuthMnager.authChangeNotifier,
            builder: (context, token, child) {
              if (token != '') {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Scaffold(
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.startFloat,
                    floatingActionButton: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 130,
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (context) =>
                                              CreateTicketBloc(),
                                        ),
                                        BlocProvider<TicketBloc>.value(
                                          value: locator.get<TicketBloc>(),
                                        ),
                                      ],
                                      child: InputTicket(),
                                    );
                                  },
                                ),
                              );
                            },
                            isExtended: true,
                            tooltip: 'تیکت جدید',
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            heroTag: '1',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  PhosphorIconsBold.plus,
                                  color: Colors.white,
                                ),
                                Text(
                                  'تیکت جدید',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    appBar: AppBar(
                      centerTitle: true,
                      automaticallyImplyLeading: false,
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return BlocProvider(
                                create: (context) => ProjectBloc(),
                                child: DashboardScreen(
                                  selected: 1,
                                ),
                              );
                            }));
                          },
                          icon: const PhosphorIcon(
                            PhosphorIconsRegular.arrowRight,
                          ),
                        )
                      ],
                      title: Text(
                        'تیکت ها',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      backgroundColor: Colors.white,
                      iconTheme: const IconThemeData(color: Colors.black),
                    ),
                    body: BlocBuilder<TicketBloc, TicketState>(
                      builder: (context, state) {
                        if (state is TicketLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: AppColorScheme.primaryColor,
                          ));
                        } else if (state is TicketResponseState) {
                          return state.getTicket.fold(
                            (l) => Text(l), // Handle error
                            (ticketResponse) {
                              _sortTickets(ticketResponse.data);
                              if (ticketResponse.data.isNotEmpty) {
                                return CustomScrollView(
                                  slivers: [
                                    SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                          final ticket = sortedTickets[index];
                                          return BlocProvider(
                                            create: (context) => TicketBloc(),
                                            child: Dismissible(
                                              direction:
                                                  DismissDirection.startToEnd,
                                              background: Container(
                                                color: Colors.red,
                                                alignment:
                                                    Alignment.centerRight,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: const Row(
                                                  children: [
                                                    PhosphorIcon(
                                                      PhosphorIconsRegular
                                                          .trash,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text('بستن',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: 'IR')),
                                                  ],
                                                ),
                                              ),
                                              confirmDismiss:
                                                  (direction) async {
                                                if (ticket.status != 3) {
                                                  await _showConfirmationBottomSheet(
                                                      ticket.uuid);
                                                  return false;
                                                }
                                              },
                                              key: Key(ticket.uuid),
                                              child: ListTile(
                                                tileColor: ticket.status == 3
                                                    ? Colors.grey
                                                        .withOpacity(0.12)
                                                    : null,
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return MultiBlocProvider(
                                                          providers: [
                                                            BlocProvider(
                                                              create: (context) =>
                                                                  CreateTicketBloc(),
                                                            ),
                                                            BlocProvider(
                                                              create: (context) =>
                                                                  TicketBloc(),
                                                            ),
                                                          ],
                                                          child: ChatBox(
                                                              ticket.uuid),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                  BlocProvider.of<TicketBloc>(
                                                          context)
                                                      .add(
                                                    GetTicketEvent(
                                                      ticket.uuid,
                                                    ),
                                                  );
                                                },
                                                shape: Border.all(
                                                    width: 0.5,
                                                    color:
                                                        Colors.grey.shade200),
                                                isThreeLine: true,
                                                style: ListTileStyle.list,

                                                leading: ticket.status == 1
                                                    ? const Icon(
                                                        PhosphorIconsRegular
                                                            .chatsCircle,
                                                        color: AppColorScheme
                                                            .primaryColor,
                                                      )
                                                    : ticket.status == 2
                                                        ? Badge(
                                                            alignment: Alignment
                                                                .topRight,
                                                            isLabelVisible:
                                                                ticket.status ==
                                                                        2
                                                                    ? true
                                                                    : false,
                                                            child: const Icon(
                                                              PhosphorIconsRegular
                                                                  .chatsCircle,
                                                              color: AppColorScheme
                                                                  .primaryColor,
                                                            ),
                                                          )
                                                        : const Icon(
                                                            PhosphorIconsRegular
                                                                .chatsCircle,
                                                            color: AppColorScheme
                                                                .primaryColor,
                                                          ),
                                                //title: TicketStatusWidget(ticket: ticket),
                                                title: Text(
                                                  "عنوان: ${ticket.title}",
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 12,
                                                      fontFamily: 'IR'),
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "موضوع: ${ticket.description}",
                                                      softWrap: true,
                                                      style: const TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 12,
                                                          fontFamily: 'IR',
                                                          color: Colors.black87,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "تاریخ ارسال: ${DateTime.parse(ticket.createdAt).toPersianDateStr()}",
                                                      softWrap: true,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                  ],
                                                ),
                                                // trailing: ,
                                                minVerticalPadding: 20,
                                                visualDensity:
                                                    VisualDensity.comfortable,
                                                dense: true,
                                                trailing: TicketStatusWidget(
                                                    ticket: ticket),
                                              ),
                                            ),
                                          );
                                        },
                                        childCount: ticketResponse.data.length,
                                      ),
                                    ),
                                    if (ticketResponse.prevPageUrl != null ||
                                        ticketResponse.nextPageUrl != null)
                                      SliverToBoxAdapter(
                                        child: Container(
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  if (ticketResponse
                                                          .prevPageUrl !=
                                                      null) {
                                                    BlocProvider.of<TicketBloc>(
                                                            context)
                                                        .add(
                                                      TicketStartEvent(
                                                        page: ticketResponse
                                                                .prevPageUrl!
                                                                .isNotEmpty
                                                            ? ticketResponse
                                                                    .currentPage! -
                                                                1
                                                            : ticketResponse
                                                                .currentPage!,
                                                        perPage: ticketResponse
                                                            .perPage,
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Text(
                                                  'صفحه قبل',
                                                  style: TextStyle(
                                                    color: ticketResponse
                                                                .prevPageUrl !=
                                                            null
                                                        ? Colors.blueAccent
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  if (ticketResponse
                                                          .nextPageUrl !=
                                                      null) {
                                                    BlocProvider.of<TicketBloc>(
                                                            context)
                                                        .add(
                                                      TicketStartEvent(
                                                        page: ticketResponse
                                                                .nextPageUrl!
                                                                .isNotEmpty
                                                            ? ticketResponse
                                                                    .currentPage! +
                                                                1
                                                            : ticketResponse
                                                                .currentPage!,
                                                        perPage: ticketResponse
                                                            .perPage,
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Text(
                                                  'صفحه بعد',
                                                  style: TextStyle(
                                                    color: ticketResponse
                                                                .nextPageUrl !=
                                                            null
                                                        ? Colors.blueAccent
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    const SliverToBoxAdapter(
                                      child: SizedBox(
                                        height: 70,
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Center(
                                  child: Column(
                                    children: [
                                      Lottie.asset('assets/images/empty.json'),
                                      const Text(
                                        'صندوق پیام ها خالی میباشد',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'IR',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          );
                        } else {
                          // Return a default widget when state is neither TicketLoadingState nor TicketResponseState
                          return Container(); // You can replace this with your default widget or an appropriate one
                        }
                      },
                    ),
                  ),
                );
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
            }),
      ),
    );
  }
}

class TicketStatusWidget extends StatelessWidget {
  final Ticket ticket;

  const TicketStatusWidget({required this.ticket, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = ticket.status;
    String statusText;

    if (status == 1) {
      statusText = 'جدید';
    } else if (status == 2) {
      statusText = 'پاسخ داده شده';
    } else {
      statusText = 'بسته شده';
    }

    return Text(
      "وضعیت: $statusText",
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}
