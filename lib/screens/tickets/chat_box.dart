import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/utils/error_snack.dart';
import 'package:smartfunding/utils/success_snack.dart';
import '../../../bloc/ticket/create_ticket/create_ticket_bloc.dart';
import '../../../bloc/ticket/create_ticket/create_ticket_event.dart';
import '../../../bloc/ticket/create_ticket/create_ticket_state.dart';
import '../../bloc/ticket/get_Ticket/ticket_bloc.dart';
import '../../bloc/ticket/get_Ticket/ticket_event.dart';
import '../../bloc/ticket/get_Ticket/ticket_state.dart';
import 'message_box.dart';

class ChatBox extends StatefulWidget {
  final String uuid;
  const ChatBox(this.uuid, {super.key});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<CreateTicketBloc>(context).add(CreateTicketStartEvent());
    BlocProvider.of<TicketBloc>(context).add(
      GetTicketEvent(widget.uuid),
    );
  }

  @override
  final TextEditingController messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return BlocListener<CreateTicketBloc, CreateTicketState>(
      listener: (context, state) {
        if (state is CreateMessageResponseState) {
          state.response.fold(
            (l) {
              showErrorSnackBar(context, l);
            },
            (r) {
              showSuccessSnackBar(context, r);
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
          );
        }
      },
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
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              resizeToAvoidBottomInset: false,

              // floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
              // floatingActionButton: Container(
              //   width: 100,
              //   height: 80,
              //   child:
              // ),
              backgroundColor: Colors.white,
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'چت تیکت',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
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
                    icon: const PhosphorIcon(
                      PhosphorIconsRegular.arrowRight,
                    ),
                  ),
                ],
              ),
              body: BlocBuilder<TicketBloc, TicketState>(
                builder: (context, state) {
                  if (state is TicketLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColorScheme.primaryColor,
                      ),
                    );
                  }
                  if (state is GetTicketResponseState) {
                    return state.getTicket.fold(
                        (l) => Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<TicketBloc>(context).add(
                                      GetTicketEvent(widget.uuid),
                                    );
                                  },
                                  child: const Text('تلاش مجدد')),
                            ), (ticket) {
                      return Column(
                        children: [
                          Expanded(
                            child: CustomScrollView(
                              slivers: [
                                SliverToBoxAdapter(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: AppColorScheme.primaryColor),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: Row(
                                                children: [
                                                  const Icon(
                                                    PhosphorIconsRegular
                                                        .envelopeSimpleOpen,
                                                    color: AppColorScheme
                                                        .primaryColor,
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    ticket.user.fullName!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall,
                                                  ),
                                                ],
                                              ),
                                              trailing: Text(
                                                ticket.createdAt
                                                    .toPersianDate(),
                                                style: const TextStyle(
                                                    fontSize: 8,
                                                    fontFamily: 'IR'),
                                              ),
                                            ),
                                            Text(
                                              ' موضوع:${ticket.title}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              ' توضیحات:${ticket.description}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      final message = ticket.messages[index];
                                      bool admin =
                                          ticket.messages[index].user.isAdmin!;

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        child: Container(
                                          width: 100,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColorScheme
                                                    .primaryColor),
                                            borderRadius: BorderRadius.only(
                                              topRight: admin
                                                  ? const Radius.circular(0)
                                                  : const Radius.circular(10),
                                              topLeft: admin
                                                  ? const Radius.circular(10)
                                                  : const Radius.circular(0),
                                              bottomLeft:
                                                  const Radius.circular(10),
                                              bottomRight:
                                                  const Radius.circular(10),
                                            ),
                                            color: admin
                                                ? Colors.blue.withOpacity(0.13)
                                                : Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ListTile(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  title: Row(
                                                    children: [
                                                      const Icon(
                                                        PhosphorIconsRegular
                                                            .userCircle,
                                                        color: AppColorScheme
                                                            .primaryColor,
                                                      ),
                                                      const SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        message.user.fullName!,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily: 'IR'),
                                                      ),
                                                    ],
                                                  ),
                                                  trailing: Text(
                                                    message.createdAt
                                                        .toPersianDate(),
                                                    style: const TextStyle(
                                                      fontSize: 8,
                                                      fontFamily: 'IR',
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  ' پیام:${message.text}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    childCount: ticket.messages.length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (ticket.status != 3) ...{
                            Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Form(
                                key: _formKey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 8,
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: TextFormField(
                                            controller: messageController,
                                            maxLines: null,
                                            style: const TextStyle(
                                                fontSize: 12, fontFamily: 'IR'),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 15),
                                              border: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColorScheme
                                                        .primaryColor,
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              labelText: 'پیام',
                                              labelStyle: const TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'IR'),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: AppColorScheme
                                                      .primaryColor,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'لطفا متن پیام را پر کنید';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: BlocBuilder<CreateTicketBloc,
                                            CreateTicketState>(
                                          builder: (context, state) {
                                            if (state
                                                is CreateTicketLoadingState) {
                                              return const CircularProgressIndicator(
                                                color:
                                                    AppColorScheme.primaryColor,
                                              );
                                            } else {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 3),
                                                child: Container(
                                                  //height: 100,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey.shade100,
                                                    // border: Border.all(
                                                    //     color: Colors.blue, width: 0.5),
                                                  ),
                                                  child: Center(
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      tooltip: 'ارسال',
                                                      onPressed: () {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          BlocProvider.of<
                                                                      CreateTicketBloc>(
                                                                  context)
                                                              .add(
                                                            CreateMessageClickedEvent(
                                                              ticket.uuid,
                                                              messageController
                                                                  .text,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      icon: const Icon(
                                                        PhosphorIconsBold
                                                            .paperPlaneRight,
                                                        size: 34,
                                                        color: AppColorScheme
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          }
                        ],
                      );
                    });
                  }
                  return Container();
                },
              )),
        ),
      ),
    );
  }
}
