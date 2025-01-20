part of 'invites_bloc.dart';

abstract class InvitesEvent {}

class InvitesStartEvent extends InvitesEvent {}

class GetInvitesByProjectEvent extends InvitesEvent {
  String? prjectUUid;
  GetInvitesByProjectEvent({this.prjectUUid});
}
