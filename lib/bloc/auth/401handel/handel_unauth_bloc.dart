import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartfunding/data/repository/profile_repository.dart';
import 'package:smartfunding/di/di.dart';

import 'handel_unauth_event.dart';
import 'handel_unauth_state.dart';

class HandelBloc extends Bloc<HandelEvent, HandelState> {
  final IProfileRepository _profileRepository = locator.get();
  HandelBloc() : super(HandelInitState()) {
    on((event, emit) async {
      if (event is HandelStartEvent) {
        emit(HandelLoadingState());
        var getProfile = await _profileRepository.getProfile();
        emit(HandelResponseState(getProfile));
      }
    });
  }
}
