part of 'users_bloc.dart';

@immutable
sealed class UsersState {}

final class UsersLoading extends UsersState {}

final class UsersLoaded extends UsersState {
  final List<UserEntity> users;

  UsersLoaded(this.users);
}

final class UsersFailure extends UsersState {}

final class UsersEmpty extends UsersState {}
