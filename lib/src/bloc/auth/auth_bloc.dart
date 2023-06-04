import 'package:academic_system/src/helper/user_token_check.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/model/user_login_request.dart';
import 'package:academic_system/src/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository repository;

  AuthBloc({required this.repository}) : super(AuthInitial()) {
    on<Login>((event, emit) async {
      // Sebaiknya ganti LoginLoading agar tidak sama dengan Auth
      emit(AuthLoading());

      final UserLoginRequest userLoginRequest =
          UserLoginRequest(id: event.id, password: event.password);

      try {
        final User? user = await repository.login(userLoginRequest);
        if (user != null) {
          emit(AuthSuccess(user: user));
        } else {
          emit(const LoginFailed(message: "User not found"));
        }
      } on Exception catch (e) {
        emit(LoginFailed(message: e.toString()));
      }
    });

    on<Auth>((event, emit) async {
      emit(AuthLoading());
      User? user = await UserTokenCheck.isSet();

      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(AuthFailed());
      }
    });
  }
}
