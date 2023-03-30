import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserResponse {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<User> data;

  UserResponse({
    this.page = 1,
    this.perPage = 10,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(fromJson: idFromJson)
  int id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  User(
      {required this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.avatar});

  static int idFromJson(dynamic value) {
    return int.parse(value.toString());
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
