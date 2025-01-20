import 'package:bloc/bloc.dart';
import 'package:smartfunding/bloc/auth/edit_profile/edit_profile_event.dart';
import 'package:smartfunding/bloc/auth/edit_profile/edit_profile_state.dart';
import 'package:smartfunding/data/repository/profile_repository.dart';
import 'package:smartfunding/di/di.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final IProfileRepository _profileRepository = locator.get();
  EditProfileBloc() : super(EditProfileInitState()) {
    on((event, emit) async {
      if (event is EditProfileButtonClickEvent) {
        emit(EditProfileLoadingState());
        var editProfile = await _profileRepository.updateProfile(
           event.name,
            event.type,
            event.mobile,
            event.nationalCode);

        emit(EditProfileResponseState(editProfile));
      }
    });
  }
}
