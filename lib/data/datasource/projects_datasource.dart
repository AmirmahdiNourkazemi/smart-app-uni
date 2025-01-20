import 'package:dio/dio.dart';
import 'package:smartfunding/data/model/investers/use_data.dart';
import 'package:smartfunding/data/model/projects/Projects.dart';
import 'package:smartfunding/utils/auth_manager.dart';

import '../../di/di.dart';
import '../../utils/api_exeption.dart';
import '../model/projects/Root.dart';
import '../model/warranty/warranty.dart';

abstract class IProjectsDatasource {
  Future<Root> getProjects();
  Future<Project> getProject(String uuid);
  Future<String> getCertificate(String projectUuid);
  Future<Pagination> getInvesters(String projectUuid, int perPage, int page);
  Future<List<Waranty>> getWarranty();
}

class ProjectsDtasource extends IProjectsDatasource {
  String token = AuthMnager.readAuth();
  final Dio _dio = locator.get();
  @override
  Future<Root> getProjects() async {
    Response response = await _dio.get(
      '/projects',
    );
    if (response.statusCode == 200) {
      return Root.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  @override
  Future<Project> getProject(String uuid) async {
    Response response = await _dio.get(
      '/projects/$uuid',
    );
    if (response.statusCode == 200) {
      return Project.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  @override
  Future<String> getCertificate(String projectUuid) async {
    try {
      var response = await _dio.get(
        '/projects/$projectUuid/certificate/pdf',
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );
      return response.data['link'];
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiExeption('unknown error happend', 0);
    }
  }

  @override
  Future<Pagination> getInvesters(
      String projectUuid, int perPage, int page) async {
    try {
      var response = await _dio.get(
        '/projects/$projectUuid/investers',
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
        queryParameters: {'per_page': perPage, 'page': page},
      );
      return Pagination.fromJson(response.data);
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiExeption('unknown error happend', 0);
    }
  }

  @override
  Future<List<Waranty>> getWarranty() async {
    try {
      var response = await _dio.get(
        '/warranties',
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );
      return List<Waranty>.from(response.data.map((x) => Waranty.fromJson(x)));
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiExeption('unknown error happend', 0);
    }
  }
}
