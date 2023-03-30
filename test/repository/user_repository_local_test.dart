import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reqresapp/model/user_model.dart';
import 'package:reqresapp/repository/user_repository.dart';
import 'package:reqresapp/repository/user_repository_local.dart';
import 'package:reqresapp/service/user_service.dart';

import 'user_repository_local_test.mocks.dart';

@GenerateMocks([UserService, User, UserResponse])
void main() {
  late MockUserService mockUserService;
  late UserRepository recruitersRepository;
  late User user;
  setUp(() {
    mockUserService = MockUserService();
    recruitersRepository = UserRepositoryLocal(mockUserService);
    user = User(
        id: 0,
        email: 'test@gmail.com',
        avatar: '',
        firstName: 'Habeeb',
        lastName: 'Olorunishola');
  });

  test('when called, should return list of users', () async {
    final generateMockData = List.generate(
      20,
      (index) => MockUser(),
    );

    final generateUserResponseMockData = MockUserResponse();
    when(mockUserService.fetchUsers(1, 10))
        .thenAnswer((_) async => Future.value(
              generateUserResponseMockData,
            ));

    final response = await recruitersRepository.getUsers(1, perPage: 10);
    verify(mockUserService.fetchUsers(1, 10));
    expect(response, generateUserResponseMockData);
  });

  test('when called, should add new user', () async {
    final generateMockData = MockUser();
    when(mockUserService.addUser(generateMockData))
        .thenAnswer((_) async => Future.value(
              generateMockData,
            ));
    final response = await recruitersRepository.addUser(generateMockData);
    verify(mockUserService.addUser(generateMockData));
    expect(response, generateMockData);
  });

  test('test the expected value against input value', () async {
    final generateMockData = User(
        id: 0,
        email: 'test@gmail.com',
        avatar: '',
        firstName: 'Habeeb',
        lastName: 'Olorunishola');
    when(mockUserService.addUser(generateMockData))
        .thenAnswer((_) async => Future.value(
              user,
            ));
    final response = await recruitersRepository.addUser(generateMockData);
    expect(response.email, generateMockData.email);
    expect(response.firstName, generateMockData.firstName);
    expect(response.id, isNonNegative);
    expect(response.avatar, isEmpty);
  });
}
