import 'package:reqresapp/model/user_model.dart';

abstract class UserRepository {
  Future<UserResponse> getUsers(int page, {int perPage = 10});
  Future<User> addUser(User user);
}
