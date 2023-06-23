import 'package:academic_system/src/repository/tagihan_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:academic_system/src/model/rincian_tagihan.dart';
part 'rincian_tagihan_event.dart';
part 'rincian_tagihan_state.dart';

class RincianTagihanBloc
    extends Bloc<RincianTagihanEvent, RincianTagihanState> {
  final TagihanRepository tagihanRepository;

  RincianTagihanBloc({
    required this.tagihanRepository,
  }) : super(RincianTagihanInitial()) {
    on<GetListRincianTagihan>((event, emit) async {
      emit(RincianTagihanLoading());

      final List<RincianTagihan> listRincianTagihan =
          await tagihanRepository.getRincianTagihan(event.idTagihanPembayaran);

      if (listRincianTagihan.isNotEmpty) {
        emit(RincianTagihanLoaded(listRincianTagihan: listRincianTagihan));
      } else {
        emit(RincianTagihanNotFound());
      }
    });
  }
}
