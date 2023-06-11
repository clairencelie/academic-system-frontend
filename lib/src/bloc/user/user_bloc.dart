import 'package:academic_system/src/model/lecturer.dart';
import 'package:academic_system/src/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc({required this.repository}) : super(UserInitial()) {
    on<GetLecturer>((event, emit) async {
      emit(UserLoading());

      List<Lecturer> lecturers = await repository.getLecturer();

      if (lecturers.isNotEmpty) {
        emit(LecturerFound(lecturers: lecturers));
      } else if (lecturers.isEmpty) {
        emit(const UserNotFound(message: "Lecturer not found"));
      }
    });
  }
}
