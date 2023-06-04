import 'package:academic_system/app.dart';
import 'package:academic_system/src/bloc/auth/auth_bloc.dart';
import 'package:academic_system/src/bloc/schedule/schedule_bloc.dart';
import 'package:academic_system/src/repository/schedule_repository.dart';
import 'package:academic_system/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => ScheduleRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              repository: RepositoryProvider.of<UserRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => ScheduleBloc(
                repository: RepositoryProvider.of<ScheduleRepository>(context)),
          )
        ],
        child: const App(),
      ),
    );
    // return const App();
  }
}
