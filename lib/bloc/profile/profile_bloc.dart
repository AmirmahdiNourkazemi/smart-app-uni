import 'package:bloc/bloc.dart';
import 'package:smartfunding/bloc/profile/profile_event.dart';
import 'package:smartfunding/bloc/profile/profile_state.dart';

import '../../data/repository/profile_repository.dart';
import '../../di/di.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IProfileRepository _profileRepository = locator.get();
  ProfileBloc() : super(ProfileInitState()) {
    on((event, emit) async {
      if (event is ProfileStartEvent) {
        emit(ProfileLoadingState());
        var getProfile = await _profileRepository.getProfile();
        emit(ProfileResponseState(getProfile));
      }
      if (event is ProfileLogoutEvent) {
        emit(ProfileLoadingState());
        var logout = await _profileRepository.logout();
        emit(ProfileLogoutState(logout));
      }
    });
  }
}
