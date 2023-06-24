import 'package:academic_system/src/repository/tagihan_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:academic_system/src/model/tagihan_perkuliahan.dart';

part 'tagihan_perkuliahan_event.dart';
part 'tagihan_perkuliahan_state.dart';

class TagihanPerkuliahanBloc
    extends Bloc<TagihanPerkuliahanEvent, TagihanPerkuliahanState> {
  final TagihanRepository tagihanRepository;

  TagihanPerkuliahanBloc({
    required this.tagihanRepository,
  }) : super(TagihanPerkuliahanInitial()) {
    on<GetListTagihan>((event, emit) async {
      emit(TagihanPerkuliahanLoading());

      final List<TagihanPerkuliahan> listTagihan =
          await tagihanRepository.getTagihanMahasiswa(event.nim);

      emit(TagihanPerkuliahanLoaded(listTagihan: listTagihan));
    });
  }
}
