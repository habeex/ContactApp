import 'package:reqresapp/model/user_model.dart';

abstract class UserService {
  Future<UserResponse> fetchUsers(int page, int perPage);
  Future<User> addUser(User user);
}
