import 'package:academic_system/app.dart';
import 'package:academic_system/src/bloc/auth/auth_bloc.dart';
import 'package:academic_system/src/bloc/dosen/dosen_bloc.dart';
import 'package:academic_system/src/bloc/khs/khs_bloc.dart';
import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/bloc/krs_management/krs_management_bloc.dart';
import 'package:academic_system/src/bloc/mata_kuliah/mata_kuliah_bloc.dart';
import 'package:academic_system/src/bloc/schedule/schedule_bloc.dart';
import 'package:academic_system/src/bloc/schedule_management/schedule_management_bloc.dart';
import 'package:academic_system/src/bloc/tahun_akademik/tahun_akademik_bloc.dart';
import 'package:academic_system/src/bloc/user/user_bloc.dart';
import 'package:academic_system/src/repository/khs_repository.dart';
import 'package:academic_system/src/repository/krs_repository.dart';
import 'package:academic_system/src/repository/mata_kuliah_repository.dart';
import 'package:academic_system/src/repository/nilai_repository.dart';
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
        RepositoryProvider(
          create: (context) => MataKuliahRepository(),
        ),
        RepositoryProvider(
          create: (context) => KrsRepository(),
        ),
        RepositoryProvider(
          create: (context) => KhsRepository(),
        ),
        RepositoryProvider(
          create: (context) => NilaiRepository(),
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
            create: (context) => UserBloc(
              repository: RepositoryProvider.of<UserRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => ScheduleBloc(
                repository: RepositoryProvider.of<ScheduleRepository>(context)),
          ),
          BlocProvider(
            create: (context) => ScheduleManagementBloc(
                repository: RepositoryProvider.of<ScheduleRepository>(context)),
          ),
          BlocProvider(
            create: (context) => MataKuliahBloc(
              repository: RepositoryProvider.of<MataKuliahRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => KrsBloc(
              repository: RepositoryProvider.of<KrsRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => KrsManagementBloc(
              repository: RepositoryProvider.of<KrsRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => KhsBloc(
              repository: RepositoryProvider.of<KhsRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => DosenBloc(
              repository: RepositoryProvider.of<NilaiRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => TahunAkademikBloc(
              repository: RepositoryProvider.of<NilaiRepository>(context),
            ),
          ),
        ],
        child: const App(),
      ),
    );
    // return const App();
  }
}
