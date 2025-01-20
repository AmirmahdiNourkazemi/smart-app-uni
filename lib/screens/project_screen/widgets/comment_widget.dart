import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smartfunding/bloc/comment/comment_bloc.dart';
import 'package:smartfunding/bloc/comment/comment_event.dart';
import 'package:smartfunding/constant/color.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/utils/auth_manager.dart';
import 'package:smartfunding/utils/error_snack.dart';
import 'package:smartfunding/utils/success_snack.dart';

import '../../../bloc/comment/comment_state.dart';
import '../../../data/model/comments/comment_data.dart';
import '../../../data/model/projects/Projects.dart';

class BuildCommentWidget extends StatefulWidget {
  final Project project;
  final double width;
  final double height;
  final ScrollController scrollController;
  const BuildCommentWidget({
    super.key,
    required this.project,
    required this.width,
    required this.height,
    required this.scrollController,
  });

  @override
  State<BuildCommentWidget> createState() => _BuildCommentWidgetState();
}

class _BuildCommentWidgetState extends State<BuildCommentWidget> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    BlocProvider.of<CommentBloc>(context).add(CommentInitEvent());
    BlocProvider.of<CommentBloc>(context)
        .add(CommentGetEvent(widget.project.uuid!));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  void _handleReply(int parentId) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        final bloc = BlocProvider.of<CommentBloc>(
            context); // Get the bloc from the outer context
        TextEditingController replyController = TextEditingController();
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            surfaceTintColor: Colors.white,
            content: TextFormField(
              maxLines: null,
              maxLength: null,
              controller: replyController,
              style: const TextStyle(
                fontFamily: 'IR',
                fontSize: 12,
                color: Colors.black87,
              ),
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: AppColorScheme.primaryColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  labelText: 'ثبت نظر',
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontFamily: 'IR',
                  )),
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            alignment: Alignment.bottomCenter,
            actionsOverflowAlignment: OverflowBarAlignment.end,
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: AppColorScheme.primaryColor,
                    ),
                  ),
                ),
                onPressed: () {
                  bloc.add(
                    CommentAddEvent(
                      widget.project.uuid!,
                      replyController.text,
                      parentID: parentId.toString(),
                    ),
                  );
                  Navigator.pop(dialogContext);
                },
                child: Text(
                  'ثبت نظر',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              ElevatedButton(
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
                  Navigator.pop(dialogContext);
                },
                child: Text(
                  'انصراف',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  TextEditingController _controller = TextEditingController();
  bool auth = AuthMnager.authChangeNotifier.value == '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommentBloc, CommentState>(
      listener: (context, state) {
        if (state is CommentStoreResponseState) {
          state.response.fold((l) {
            showErrorSnackBar(context, l);
          }, (r) {
            _controller.clear();
            showSuccessSnackBar(context, r);
          });
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (!auth)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'نظرات',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            const SizedBox(
              height: 10,
            ),
            if (!auth)
              Container(
                width: widget.width,
                // height: widget.height,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300, // Set the border color
                    width: 1.0, // Set the border width
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      if (!auth)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFormField(
                            style: const TextStyle(
                              fontFamily: 'IR',
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                            controller: _controller,
                            maxLines: null,
                            maxLength: null,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: AppColorScheme.primaryColor),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                labelText: 'ثبت نظر',
                                labelStyle: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'IR',
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'لطفا نظر خود را بنویسید';
                              }
                              return null;
                            },
                          ),
                        ),
                      if (!auth)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<CommentBloc>(context).add(
                                  CommentAddEvent(
                                    widget.project.uuid!,
                                    _controller.text,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(widget.width, 50),
                                backgroundColor: const Color(0xff074EA0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: BlocBuilder<CommentBloc, CommentState>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (state is CommentLoading) ...{
                                      Text(
                                        'درحال ارسال',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                      const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    } else ...{
                                      Text(
                                        'ثبت نظر',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      )
                                    }
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      const SizedBox(height: 16),
                      if (!auth)
                        BlocBuilder<CommentBloc, CommentState>(
                          builder: (context, state) {
                            if (state is CommentGetLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is CommentResponseState) {
                              return state.getComments.fold((l) => Text(l),
                                  (comments) {
                                if (comments.data!.isNotEmpty) {
                                  return ListView.builder(
                                    controller: widget.scrollController,
                                    shrinkWrap: true,
                                    itemCount: comments.data!.length,
                                    itemBuilder: (context, index) {
                                      final isLastIndex =
                                          index == comments.data!.length - 1;
                                      CommentData comment =
                                          comments.data![index];

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            contentPadding:
                                                const EdgeInsetsDirectional
                                                    .symmetric(horizontal: 5),
                                            title: Row(
                                              children: [
                                                Text(
                                                  comment.user.fullName!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  comment.createdAt
                                                      .toPersianDate(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineSmall,
                                                ),
                                              ],
                                            ),
                                            subtitle: Text(
                                              comment.body,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .copyWith(height: 1.8),
                                            ),
                                            leading: const PhosphorIcon(
                                              PhosphorIconsRegular.userCircle,
                                              color:
                                                  AppColorScheme.primaryColor,
                                            ),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextButton.icon(
                                                  onPressed: () =>
                                                      _handleReply(comment.id),
                                                  icon: const PhosphorIcon(
                                                      PhosphorIconsRegular
                                                          .arrowBendUpLeft),
                                                  label: Text(
                                                    'پاسخ',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          if (comment.replies != null)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: ListView.builder(
                                                controller:
                                                    widget.scrollController,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    comment.replies?.length ??
                                                        0,
                                                itemBuilder:
                                                    (context, replyIndex) {
                                                  var reply = comment
                                                      .replies![replyIndex];
                                                  return ListTile(
                                                    leading: const PhosphorIcon(
                                                      PhosphorIconsRegular
                                                          .arrowBendUpRight,
                                                      color: Colors.grey,
                                                    ),
                                                    subtitle: Text(
                                                      reply.body!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                              height: 1.8),
                                                    ),
                                                    title: Row(
                                                      children: [
                                                        Text(
                                                          reply.user!.fullName!,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelMedium,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          reply.updatedAt!
                                                              .toPersianDate(),
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headlineSmall,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          if (!isLastIndex)
                                            Divider(
                                              color: Colors.grey.shade200,
                                            )
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  return ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'هیچ نظری وجود ندارد',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),
                                      ],
                                    ),
                                    // subtitle: Text('By: ${comment.user.fullName}'),
                                    // trailing: IconButton(
                                    //   icon: Icon(Icons.reply),
                                    //   onPressed: () => null,
                                    // ),
                                  );
                                }
                              });
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
