import 'package:academic_system/src/repository/nilai_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:academic_system/src/model/nilai_mhs.dart';
import 'package:academic_system/src/model/matkul_dosen.dart';

part 'dosen_event.dart';
part 'dosen_state.dart';

class DosenBloc extends Bloc<DosenEvent, DosenState> {
  final NilaiRepository repository;

  DosenBloc({required this.repository}) : super(DosenInitial()) {
    on<GetMatkulDosen>((event, emit) async {
      emit(DosenLoading());

      final List<MatkulDosen> matkulDosen =
          await repository.getMatkulDosen(event.idDosen);

      if (matkulDosen.isNotEmpty) {
        emit(MatkulDosenFound(matkulDosen: matkulDosen));
      } else {
        emit(MatkulDosenNotFound());
      }
    });

    on<GetNilaiMhs>((event, emit) async {
      emit(DosenLoading());

      final List<NilaiMahasiswa> nilaiMhsList = await repository.getNilaiMhs(
        event.idMataKuliah,
        event.tahunAkademik,
        event.semester,
      );

      print(nilaiMhsList);
      if (nilaiMhsList.isNotEmpty) {
        emit(NilaiMhsFound(nilaiMhsList: nilaiMhsList));
      } else {
        emit(NilaiMhsNotFound());
      }
    });
  }
}
