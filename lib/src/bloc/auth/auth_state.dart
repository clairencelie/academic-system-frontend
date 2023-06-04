part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class AuthFailed extends AuthState {}

class LoginFailed extends AuthState {
  final String message;

  const LoginFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
