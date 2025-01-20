import 'package:bloc/bloc.dart';
import 'package:smartfunding/bloc/projects/project_event.dart';
import 'package:smartfunding/bloc/projects/project_state.dart';

import '../../data/repository/project_repository.dart';
import '../../di/di.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final IProjectsRepository _iProjectsRepository = locator.get();
  ProjectBloc() : super(ProjectInitState()) {
    on((event, emit) async {
      if (event is ProjectStartEvent) {
        emit(ProjectLoadingState());
        var getProjet = await _iProjectsRepository.getProjects();
        emit(ProjectResponseState(getProjet));
      }
      if (event is ProjectIDStartEvent) {
        emit(ProjectLoadingState());
        var getProjetID = await _iProjectsRepository.getProject(event.uuid);
        emit(ProjectIDResponseState(getProjetID));
      }
      if (event is ProjectInversterEvent) {
        emit(ProjectInvestersLoadingState());
        var getInversters = await _iProjectsRepository.getInvesters(
            event.uuid, event.per_page, event.page);
        emit(ProjectInverstersResponseState(getInversters));
      }
      if (event is ProjectWarrantyEvent) {
        emit(ProjectWarrantyLoadingState());
        var getWarranty = await _iProjectsRepository.getWarranty();
        emit(ProjectWarrantyState(getWarranty));
      }
    });
  }
}
