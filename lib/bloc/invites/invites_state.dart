part of 'invites_bloc.dart';

abstract class InvitesState {}

final class InvitesInitial extends InvitesState {}

class GetInvitesByProjectState extends InvitesState {
  Either<String, Pagination> getInvites;
  GetInvitesByProjectState(this.getInvites);
}

class GetInvitesByProjectLoadingState extends InvitesState {}
