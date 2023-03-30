import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reqresapp/bloc/user_bloc.dart';
import 'package:reqresapp/feature/user/user_screen.dart';
import 'package:reqresapp/repository/user_repository.dart';
import 'package:reqresapp/repository/user_repository_local.dart';
import 'package:reqresapp/service/api_service.dart';
import 'package:reqresapp/service/user_service_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ApiService.instance.clientSetup('https://reqres.in/api/');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<UserRepository>(
      create: (BuildContext context) => UserRepositoryLocal(
        UserServiceLocal(),
      ),
      child: MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (blocContext) => UserCubit(
                blocContext.read<UserRepository>(),
              ),
            )
          ],
          child: const UserScreen(),
        ),
      ),
    );
  }
}
