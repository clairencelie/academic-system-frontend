import 'package:academic_system/src/repository/nilai_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:academic_system/src/model/tahun_akademik.dart';

part 'tahun_akademik_event.dart';
part 'tahun_akademik_state.dart';

class TahunAkademikBloc extends Bloc<TahunAkademikEvent, TahunAkademikState> {
  final NilaiRepository repository;

  TahunAkademikBloc({required this.repository})
      : super(TahunAkademikInitial()) {
    on<GetListTA>((event, emit) async {
      emit(TahunAkademikLoading());

      final List<TahunAkademik> listTA = await repository.getTahunAkademik();

      if (listTA.isNotEmpty) {
        emit(TahunAkademikLoaded(listTA: listTA));
      } else {
        emit(TahunAkademikNotFound());
      }
    });
  }
}
