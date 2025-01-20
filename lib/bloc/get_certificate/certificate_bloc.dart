import 'package:bloc/bloc.dart';
import 'package:smartfunding/data/repository/project_repository.dart';
import '../../../di/di.dart';
import 'certificate_event.dart';
import 'certificate_state.dart';

class CertificateBloc extends Bloc<CertificateEvent, CertificateState> {
  final IProjectsRepository _iProjectsDatasource = locator.get();
  CertificateBloc() : super(CertificateInitState()) {
    on<CertificateEvent>((event, emit) async {
      if (event is CertificateStartEvent) {
        // emit(CertificateLoadingState());
      } else if (event is CertificateButtonClikedEvent) {
        emit(CertificateLoadingState());
        var getCertificate =
            await _iProjectsDatasource.getCertificate(event.projectUuid);
        emit(CertificateResponseState(getCertificate));
      }
    });
  }
}
