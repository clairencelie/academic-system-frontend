import 'package:academic_system/src/repository/mata_kuliah_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:academic_system/src/model/master_matkul.dart';

part 'master_mata_kuliah_event.dart';
part 'master_mata_kuliah_state.dart';

class MasterMataKuliahBloc
    extends Bloc<MasterMataKuliahEvent, MasterMataKuliahState> {
  final MataKuliahRepository repository;

  MasterMataKuliahBloc({required this.repository})
      : super(MasterMataKuliahInitial()) {
    on<GetMataKuliahMaster>((event, emit) async {
      emit(MasterMataKuliahLoading());

      final List<MasterMatkul> listMasterMatkul =
          await repository.getAllMataKuliahMaster();

      if (listMasterMatkul.isNotEmpty) {
        emit(MasterMataKuliahFound(listMasterMatkul: listMasterMatkul));
      } else {
        emit(MasterMataKuliahNotFound());
      }
    });
  }
}
