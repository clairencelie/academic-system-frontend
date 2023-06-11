part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class LecturerFound extends UserState {
  final List<Lecturer> lecturers;

  const LecturerFound({required this.lecturers});

  @override
  List<Object> get props => [lecturers];
}

class UserNotFound extends UserState {
  final String message;

  const UserNotFound({required this.message});

  @override
  List<Object> get props => [message];
}
