import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartfunding/bloc/projects/project_bloc.dart';
import 'package:smartfunding/data/model/projects/Projects.dart';
import 'package:smartfunding/screens/project_screen/mobile_detail_project.dart';

class NavigateDetailProject extends StatefulWidget {
  final Project _project;
  const NavigateDetailProject(this._project, {super.key});

  @override
  State<NavigateDetailProject> createState() => _NavigateDetailProjectState();
}

class _NavigateDetailProjectState extends State<NavigateDetailProject> {
  ScrollController _scrollController = ScrollController();
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: AppColorScheme.primaryColor,
      body: ListView(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        children: [
          BlocProvider(
            create: (context) => ProjectBloc(),
            child: MobileDetailScreen(_scrollController, widget._project),
          ),
        ],
      ),
    );
  }
}
