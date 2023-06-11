import 'package:academic_system/src/repository/mata_kuliah_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:academic_system/src/model/learning_subject.dart';

part 'mata_kuliah_event.dart';
part 'mata_kuliah_state.dart';

class MataKuliahBloc extends Bloc<MataKuliahEvent, MataKuliahState> {
  final MataKuliahRepository repository;

  MataKuliahBloc({required this.repository}) : super(MataKuliahInitial()) {
    on<GetMataKuliah>((event, emit) async {
      emit(MataKuliahLoading());

      List<LearningSubject> learningSubjects =
          await repository.getAllMataKuliah();

      if (learningSubjects.isNotEmpty) {
        emit(MataKuliahFound(learningSubjects: learningSubjects));
      } else if (learningSubjects.isEmpty) {
        emit(const MataKuliahNotFound(message: "Mata kuliah not found"));
      }
    });
  }
}
