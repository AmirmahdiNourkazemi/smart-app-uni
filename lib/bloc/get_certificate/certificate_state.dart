import 'package:dartz/dartz.dart';

abstract class CertificateState {}

class CertificateInitState extends CertificateState {}

class CertificateLoadingState extends CertificateState {}

class CertificateResponseState extends CertificateState {
  Either<String, String> getCertificate;
  CertificateResponseState(this.getCertificate);
}
