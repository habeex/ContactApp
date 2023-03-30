import 'package:reqresapp/model/user_model.dart';
import 'package:reqresapp/repository/user_repository.dart';
import 'package:reqresapp/service/user_service.dart';

class UserRepositoryLocal implements UserRepository {
  UserRepositoryLocal(this._usersService);

  final UserService _usersService;

  @override
  Future<UserResponse> getUsers(int page, {int perPage = 10}) =>
      _usersService.fetchUsers(page, perPage);

  @override
  Future<User> addUser(User user) => _usersService.addUser(user);
}
