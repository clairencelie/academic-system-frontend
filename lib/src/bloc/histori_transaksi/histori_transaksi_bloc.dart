import 'package:academic_system/src/repository/transaksi_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:academic_system/src/model/histori_transaksi.dart';

part 'histori_transaksi_event.dart';
part 'histori_transaksi_state.dart';

class HistoriTransaksiBloc
    extends Bloc<HistoriTransaksiEvent, HistoriTransaksiState> {
  final TransaksiRepository transaksiRepository;
  HistoriTransaksiBloc({
    required this.transaksiRepository,
  }) : super(HistoriTransaksiInitial()) {
    on<GetListHistoryTransaksi>((event, emit) async {
      emit(HistoriTransaksiLoading());

      final List<HistoriTransaksi> listHistoriTransaksi =
          await transaksiRepository.getAllListHistoriTransaksi(event.nim);

      emit(AllHistoriTransaksiLoaded(
          listHistoriTransaksi: listHistoriTransaksi));
    });
  }
}
