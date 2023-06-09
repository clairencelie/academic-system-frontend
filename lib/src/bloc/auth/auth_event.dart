part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class Login extends AuthEvent {
  final String id;
  final String password;

  const Login({
    required this.id,
    required this.password,
  });

  @override
  List<Object> get props => [id, password];
}

class Auth extends AuthEvent {}
