import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/model/projects/Projects.dart';

Widget buildAttachmentSection(
    BuildContext context, Project project, double width, double height) {
  if (project.attachments!.length > 0) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'اسناد طرح',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width,
                //height: height,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300, // Set the border color
                    width: 1.0, // Set the border width
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final isLastIndex =
                        index == project.attachments!.length - 1;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: SizedBox(
                            // width: double.infinity,
                            height: 35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    await launch(project
                                        .attachments![index].originalUrl);
                                  },
                                  child: Text(
                                    project.attachments![index].name,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                                const Icon(
                                  PhosphorIconsRegular.filePdf,
                                  color: AppColorScheme.primaryColor,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (!isLastIndex)
                          Divider(
                            color: Colors.grey.shade200,
                          )
                      ],
                    );
                  },
                  itemCount: project.attachments!.length,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  } else {
    return Container(); // Return an empty container if there are no attachments
  }
}
