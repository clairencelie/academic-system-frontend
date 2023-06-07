import 'package:academic_system/src/bloc/auth/auth_bloc.dart';
import 'package:academic_system/src/helper/platform_type_detector.dart';
import 'package:academic_system/src/helper/scroll_behavior.dart';
import 'package:academic_system/src/ui/mobile/page/loading_page.dart';
import 'package:academic_system/src/ui/mobile/page/login_page.dart';
import 'package:academic_system/src/ui/mobile/page/main_page.dart';
import 'package:academic_system/src/ui/web/page/login_page.dart';
import 'package:academic_system/src/ui/web/page/main_page.dart';
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
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial) {
            } else if (state is AuthLoading) {
              return const LoadingPage();
            } else if (state is AuthFailed) {
              return PlatformTypeDetector.platformName == 'Android'
                  ? const MobileLoginPage()
                  : const WebLoginPage();
            } else if (state is AuthSuccess) {
              return PlatformTypeDetector.platformName == 'Android'
                  ? MainPage(user: state.user)
                  : WebMainPage(user: state.user);
            }
            return PlatformTypeDetector.platformName == 'Android'
                ? const MobileLoginPage()
                : const WebLoginPage();
          },
        ),
      ),
    );
  }
}
