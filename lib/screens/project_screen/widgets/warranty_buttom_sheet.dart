import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smartfunding/bloc/projects/project_bloc.dart';
import 'package:smartfunding/bloc/projects/project_event.dart';
import 'package:smartfunding/bloc/projects/project_state.dart';
import 'package:smartfunding/constant/scheme.dart';
import 'package:smartfunding/data/model/investers/project.dart';

class WarrantyButtomSheet extends StatefulWidget {
  const WarrantyButtomSheet({super.key});

  @override
  State<WarrantyButtomSheet> createState() => _WarrantyButtomSheetState();
}

class _WarrantyButtomSheetState extends State<WarrantyButtomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        ProjectBloc bloc = ProjectBloc();
        bloc.add(ProjectWarrantyEvent());
        return bloc;
      },
      child: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          return DraggableScrollableSheet(
              expand: false,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state is ProjectWarrantyLoadingState) ...[
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ] else if (state is ProjectWarrantyState) ...[
                        state.getWarranty.fold((l) => Text(l), (_warranty) {
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _warranty.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  trailing: Icon(
                                    PhosphorIconsBold.certificate,
                                    color: AppColorScheme.primaryColor
                                        .withOpacity(1 - index * 0.1),
                                  ),
                                  title: Text(
                                    _warranty[index].title!,
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                  subtitle: Text(_warranty[index].description!,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54,
                                          )),
                                );
                              });
                        }),
                      ]
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
