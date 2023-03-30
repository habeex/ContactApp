import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reqresapp/model/user_model.dart';
import 'package:reqresapp/repository/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._recruitersRepository) : super(const InitialUserState());
  final UserRepository _recruitersRepository;
  List<User> users = [];
  void getUsers({int page = 0}) async {
    try {
      emit(const LoadingUserState());
      final response = await _recruitersRepository.getUsers(page);
      if (page > 1) {
        users.addAll(response.data);
      } else {
        users = response.data;
      }
      emit(LoadedUserState(users));
      if (page >= response.totalPages) {
        emit(const NoDataUserState());
      }
    } catch (error) {
      emit(ErrorUserState(error.toString()));
    }
  }

  void addUser(User user) async {
    try {
      emit(const LoadingUserState());
      final response = await _recruitersRepository.addUser(user);
      emit(AddUserSuccessState(response));
      users.add(response);
      emit(LoadedUserState(users));
    } catch (error) {
      emit(ErrorAddUserState(error.toString()));
    }
  }
}
