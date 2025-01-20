abstract class CertificateEvent {}

class CertificateStartEvent extends CertificateEvent {}

class CertificateButtonClikedEvent extends CertificateEvent {
  String projectUuid;
  CertificateButtonClikedEvent(this.projectUuid);
}
