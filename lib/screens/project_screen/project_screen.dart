import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartfunding/bloc/projects/project_event.dart';
import 'package:smartfunding/screens/project_screen/widgets/shimmer_widget.dart';
import '../../bloc/projects/project_bloc.dart';
import '../../bloc/projects/project_state.dart';
import 'widgets/project_container.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<ProjectBloc>(context).add(ProjectStartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            if (state is ProjectLoadingState) {
              return const ProjectDashboardShimmer();

            } else {
              if (state is ProjectResponseState) {
                return state.getProjects.fold(
                  (l) => Text(l),
                  (r) => GridView.builder(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 80),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: r.projects.length,
                    itemBuilder: (context, index) {
                      return ProjectDashboardContainer(r.projects[index]);
                    },
                  ),
                );
              }
              return Container();
            }
          },
        ),
      ),
    );
  }
}
