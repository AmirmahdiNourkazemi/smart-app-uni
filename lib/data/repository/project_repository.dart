import 'package:dartz/dartz.dart';
import 'package:smartfunding/data/model/investers/use_data.dart';
import 'package:smartfunding/data/model/projects/Projects.dart';
import 'package:smartfunding/data/model/warranty/warranty.dart';

import '../../di/di.dart';
import '../../utils/api_exeption.dart';
import '../datasource/projects_datasource.dart';
import '../model/projects/Root.dart';

abstract class IProjectsRepository {
  Future<Either<String, Root>> getProjects();
  Future<Either<String, Project>> getProject(String uuid);
  Future<Either<String, Pagination>> getInvesters(
      String uuid, int perPage, int page);
  Future<Either<String, String>> getCertificate(String projectUuid);
  Future<Either<String, List<Waranty>>> getWarranty();
}

class ProjectsRepository extends IProjectsRepository {
  @override
  final IProjectsDatasource _projectsDatasource = locator.get();
  Future<Either<String, Root>> getProjects() async {
    try {
      var response = await _projectsDatasource.getProjects();
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, Project>> getProject(String uuid) async {
    try {
      var response = await _projectsDatasource.getProject(uuid);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> getCertificate(String projectUuid) async {
    try {
      var response = await _projectsDatasource.getCertificate(projectUuid);

      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, Pagination>> getInvesters(
      String uuid, int perPage, int page) async {
    try {
      var response =
          await _projectsDatasource.getInvesters(uuid, perPage, page);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Waranty>>> getWarranty() async {
    try {
      var res = await _projectsDatasource.getWarranty();
      return right(res);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
