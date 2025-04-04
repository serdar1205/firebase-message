part of 'users_bloc.dart';

@immutable
sealed class UsersEvent {}

class GetAllUsers extends UsersEvent{}
class GetBlockedUsers extends UsersEvent{}
class BlockUser extends UsersEvent{
  final String userId;

  BlockUser(this.userId);
}
class UnBlockUser extends UsersEvent{
  final String blockedUserId;

  UnBlockUser(this.blockedUserId);
}
class ReportUser extends UsersEvent{
  final ReportUserParams params;

  ReportUser(this.params);
}
