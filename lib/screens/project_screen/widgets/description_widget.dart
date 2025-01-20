import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:smartfunding/bloc/ticket/create_ticket/create_ticket_bloc.dart';
import 'package:smartfunding/screens/tickets/input_ticket.dart';

Widget buildDescriptionSection(
  bool isDesktop,
  BuildContext context,
  String title,
  String content,
  double? width,
  double? height,
) {
  QuillController _controller = QuillController.basic();
  final json = jsonDecode(content);
  _controller.document = Document.fromJson(json);
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),

          const SizedBox(
            height: 5,
          ),

          QuillEditor.basic(
            configurations: QuillEditorConfigurations(
              controller: _controller,
              customStyles: DefaultStyles(
                  paragraph: DefaultListBlockStyle(
                      TextStyle(
                          fontSize: 12, color: Colors.black, fontFamily: 'IR'),
                      VerticalSpacing(1, 1),
                      VerticalSpacing(1, 1),
                      null,
                      null)),
              sharedConfigurations: const QuillSharedConfigurations(
                locale: Locale('fa'),
              ),
            ),
          ),
          //Text(_controller.document.toString()),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => CreateTicketBloc(),
                          ),
                        ],
                        child: InputTicket(
                          type: 3,
                        ),
                      );
                    },
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: Text(
                'ثبت تخلف',
                style: Theme.of(context).textTheme.displaySmall,
              ))
        ],
      ),
    ),
  );
}
