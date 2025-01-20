import 'package:dartz/dartz.dart';
import 'package:smartfunding/data/model/investers/use_data.dart';
import 'package:smartfunding/data/model/projects/Projects.dart';
import 'package:smartfunding/data/model/warranty/warranty.dart';

import '../../data/model/projects/Root.dart';

abstract class ProjectState {}

class ProjectInitState extends ProjectState {}

class ProjectLoadingState extends ProjectState {}

class ProjectWarrantyLoadingState extends ProjectState {}

class ProjectInvestersLoadingState extends ProjectState {}

class ProjectResponseState extends ProjectState {
  Either<String, Root> getProjects;
  ProjectResponseState(this.getProjects);
}

class ProjectIDResponseState extends ProjectState {
  Either<String, Project> getProject;
  ProjectIDResponseState(this.getProject);
}

class ProjectInverstersResponseState extends ProjectState {
  Either<String, Pagination> getInvesters;
  ProjectInverstersResponseState(this.getInvesters);
}

class ProjectWarrantyState extends ProjectState {
  Either<String, List<Waranty>> getWarranty;
  ProjectWarrantyState(this.getWarranty);
}
