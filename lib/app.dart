import 'package:academic_system/src/bloc/auth/auth_bloc.dart';
import 'package:academic_system/src/helper/platform_type_detector.dart';
import 'package:academic_system/src/ui/mobile/page/loading_page.dart';
import 'package:academic_system/src/ui/mobile/page/login_page.dart';
import 'package:academic_system/src/ui/mobile/page/main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    // Detect platform type
    PlatformTypeDetector.detect();
    context.read<AuthBloc>().add(Auth());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitial) {
            return const LoadingPage();
          } else if (state is AuthLoading) {
            return const LoadingPage();
          } else if (state is AuthFailed) {
            return PlatformTypeDetector.platformName == 'Android'
                ? const MobileLoginPage()
                : const Scaffold(
                    body: Center(
                      child: Text('WEB Main Page'),
                    ),
                  );
          } else if (state is AuthSuccess) {
            return PlatformTypeDetector.platformName == 'Android'
                ? MainPage(user: state.user)
                : const Scaffold(
                    body: Center(
                      child: Text('WEB Main Page'),
                    ),
                  );
          }
          return const Scaffold(
            body: Center(
              child: Text('Error'),
            ),
          );
        },
      ),
    );
  }
}
