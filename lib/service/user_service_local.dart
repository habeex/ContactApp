import 'package:reqresapp/config/api_routes.dart';
import 'package:reqresapp/model/user_model.dart';
import 'package:reqresapp/service/api_service.dart';
import 'package:reqresapp/service/user_service.dart';

class UserServiceLocal implements UserService {
  @override
  Future<UserResponse> fetchUsers(int page, int perPage) async {
    final response = await ApiService.instance.client
        .get('${ApiRoutes.user}?page=$page&per_page=$perPage');
    return UserResponse.fromJson(response.data);
  }

  @override
  Future<User> addUser(User user) async {
    final response = await ApiService.instance.client
        .post(ApiRoutes.user, data: user.toJson());
    return User.fromJson(response.data);
  }
}
