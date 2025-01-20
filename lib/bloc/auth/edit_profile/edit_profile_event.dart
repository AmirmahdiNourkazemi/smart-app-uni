abstract class EditProfileEvent {}

class EditProfileStartEvent extends EditProfileEvent {}

class EditProfileButtonClickEvent extends EditProfileEvent {
  String name;
  int type;
  String mobile;
  String nationalCode;
  EditProfileButtonClickEvent(
      {required this.name,
      required this.type,
      required this.mobile,
      required this.nationalCode}
  );
}
