import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:smartfunding/data/model/investers/use_data.dart';
import 'package:smartfunding/di/di.dart';

import '../../data/repository/profile_repository.dart';

part 'invites_event.dart';
part 'invites_state.dart';

class InvitesBloc extends Bloc<InvitesEvent, InvitesState> {
  final IProfileRepository _profileRepository = locator.get();
  InvitesBloc() : super(InvitesInitial()) {
    on<GetInvitesByProjectEvent>((event, emit) async {
      emit(GetInvitesByProjectLoadingState());
      var getInvites = await _profileRepository.getInvites(event.prjectUUid);
      emit(GetInvitesByProjectState(getInvites));
    });
  }
}
