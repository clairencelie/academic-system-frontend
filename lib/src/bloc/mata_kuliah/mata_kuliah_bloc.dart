import 'package:academic_system/src/repository/mata_kuliah_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:academic_system/src/model/learning_subject.dart';
import 'package:academic_system/src/model/student.dart';

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

    on<GetKRSMatkul>((event, emit) async {
      emit(MataKuliahLoading());

      List<LearningSubject> learningSubjects =
          await repository.getAllMataKuliah();

      if (learningSubjects.isNotEmpty) {
        learningSubjects.sort(
          (a, b) => a.id.compareTo(b.id),
        );
        learningSubjects.sort(
          (a, b) => a.grade.compareTo(b.grade),
        );
        if (event.student.major == 'Sistem Informasi') {
          List<LearningSubject> systemInformationSubjects = learningSubjects
              .where((learningSubject) {
                return ((int.tryParse(event.student.semester)! + 1) % 2 == 0)
                    ? int.tryParse(learningSubject.grade[1])! % 2 == 0
                    : int.tryParse(learningSubject.grade[1])! % 2 == 1;
              })
              .where((learningSubject) =>
                  learningSubject.grade.contains('MAS') ||
                  learningSubject.grade.contains('MATS'))
              .toList();

          emit(MataKuliahFound(learningSubjects: systemInformationSubjects));
        } else {
          List<LearningSubject> informationTechnologySubjects = learningSubjects
              .where((learningSubject) {
                return ((int.tryParse(event.student.semester)! + 1) % 2 == 0)
                    ? int.tryParse(learningSubject.grade[1])! % 2 == 0
                    : int.tryParse(learningSubject.grade[1])! % 2 == 1;
              })
              .where((learningSubject) =>
                  learningSubject.grade.contains('MAT') ||
                  learningSubject.grade.contains('MATS'))
              .toList();
          emit(
              MataKuliahFound(learningSubjects: informationTechnologySubjects));
        }
      } else if (learningSubjects.isEmpty) {
        emit(const MataKuliahNotFound(message: "Mata kuliah not found"));
      }
    });
  }
}
