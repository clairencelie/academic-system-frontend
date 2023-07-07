import 'package:academic_system/src/repository/mata_kuliah_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:academic_system/src/model/matkul_baru.dart';
import 'package:academic_system/src/model/learning_subject.dart';

part 'matkul_management_event.dart';
part 'matkul_management_state.dart';

class MatkulManagementBloc
    extends Bloc<MatkulManagementEvent, MatkulManagementState> {
  final MataKuliahRepository mataKuliahRepository;
  MatkulManagementBloc({
    required this.mataKuliahRepository,
  }) : super(MatkulManagementInitial()) {
    on<TambahMataKuliah>((event, emit) async {
      emit(MatkulManagementLoading());

      final String message = await mataKuliahRepository.tambahMataKuliah(
          matkulBaru: event.matkulBaru);

      if (message == 'berhasil insert mata kuliah') {
        emit(CreateMatkulSuccess());
      } else {
        emit(CreateMatkulFailed());
      }
    });

    on<UpdateMataKuliah>((event, emit) async {
      emit(MatkulManagementLoading());

      final String message = await mataKuliahRepository.updateMataKuliah(
          matkulBaru: event.matkulBaru);

      if (message == 'berhasil update mata kuliah') {
        emit(MatkulUpdateSuccess());
      } else {
        emit(MatkulUpdateFailed());
      }
    });

    on<DeleteMataKuliah>((event, emit) async {
      emit(MatkulManagementLoading());

      final String message =
          await mataKuliahRepository.deleteMataKuliah(event.id);

      if (message == 'berhasil delete mata kuliah') {
        emit(MatkulDeleteSuccess());
      } else {
        emit(MatkulDeleteFailed());
      }
    });
  }
}
