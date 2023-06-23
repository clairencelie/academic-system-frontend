import 'package:academic_system/src/repository/transaksi_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'transaksi_event.dart';
part 'transaksi_state.dart';

class TransaksiBloc extends Bloc<TransaksiEvent, TransaksiState> {
  final TransaksiRepository transaksiRepository;

  TransaksiBloc({required this.transaksiRepository})
      : super(TransaksiInitial()) {
    on<CreateTransaksi>((event, emit) async {
      emit(TransaksiLoading());

      final String message = await transaksiRepository.createCharge(
        event.idTagihanPerkuliahan,
        event.nim,
        event.totalTagihan,
      );

      if (message == 'Transaksi berhasil dibuat') {
        emit(TransaksiCreated(message: message));
      } else {
        emit(TransaksiFailed());
      }
    });
  }
}
