// ignore_for_file: must_be_immutable

part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class InitialUserState extends UserState {
  const InitialUserState();
}

class LoadingUserState extends UserState {
  const LoadingUserState();
}

class ErrorUserState extends UserState {
  String exception;
  ErrorUserState(this.exception);
}

class ErrorAddUserState extends UserState {
  String exception;
  ErrorAddUserState(this.exception);
}

class LoadedUserState extends UserState {
  List<User> users;
  LoadedUserState(this.users);
}

class AddUserSuccessState extends UserState {
  AddUserSuccessState(this.user);
  User user;
}

class NoDataUserState extends UserState {
  const NoDataUserState();
}
