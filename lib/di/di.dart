import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfunding/bloc/ticket/get_Ticket/ticket_bloc.dart';
import '../data/datasource/authentication_datasource.dart';
import '../data/datasource/comment_datasource.dart';
import '../data/datasource/payment_datasource.dart';
import '../data/datasource/profile_datasouce.dart';
import '../data/datasource/projects_datasource.dart';
import '../data/datasource/ticket_datasource.dart';
import '../data/datasource/transaction_datasource.dart';
import '../data/repository/authentication_respository.dart';
import '../data/repository/comment_repository.dart';
import '../data/repository/payment_repository.dart';
import '../data/repository/profile_repository.dart';
import '../data/repository/project_repository.dart';
import '../data/repository/ticket_repository.dart';
import '../data/repository/transaction_repository.dart';
import '../utils/auth_manager.dart';

var locator = GetIt.instance;

Future<void> getItInit() async {
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  String token = await AuthMnager.readAuth();
  locator.registerSingleton<Dio>(
    Dio(
      BaseOptions(baseUrl: 'http://194.48.198.227:9000/api', headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }),
    ),
  );

  //datasource
  locator.registerFactory<IAuthenthicationDatasource>(
      () => AuthenthicationDatasource());
  // locator.registerFactory<IUnitsDatasource>(() => UnitsDtatasource());
  locator.registerFactory<AuthMnager>(() => AuthMnager());
  locator.registerFactory<IProjectsDatasource>(() => ProjectsDtasource());
  locator.registerFactory<IPaymentDatasource>(() => PaymentDatasource());
  locator.registerFactory<IProfileDatasource>(() => ProfileDatasource());
  locator.registerFactory<ITicketDatasource>(() => TicketDatasource());
  locator.registerFactory<ITransactionDatasource>(() => TransactionDtasource());
  locator.registerFactory<ICommentDatasource>(() => CommentDatasource());
  //repository
  locator
      .registerFactory<IAuthenticationRepository>(() => AuthenticationRemote());
  locator.registerFactory<IProjectsRepository>(() => ProjectsRepository());
  // locator.registerFactory<IUnitRepository>(() => UnitRepository());
  locator.registerFactory<IPaymentRepository>(() => PaymentRepository());
  locator.registerFactory<IProfileRepository>(() => ProfileRepository());
  locator.registerFactory<ITicketRepository>(() => TicketRepository());
  locator
      .registerFactory<ITransactionRepository>(() => TransactionRepository());
  locator.registerFactory<ICommentRepository>(() => CommentRepository());
  locator.registerSingleton<TicketBloc>(TicketBloc());
}
