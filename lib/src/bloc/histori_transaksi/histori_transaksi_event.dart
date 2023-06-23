part of 'histori_transaksi_bloc.dart';

abstract class HistoriTransaksiEvent extends Equatable {
  const HistoriTransaksiEvent();

  @override
  List<Object> get props => [];
}

class GetListHistoryTransaksi extends HistoriTransaksiEvent {
  final String nim;

  const GetListHistoryTransaksi({
    required this.nim,
  });

  @override
  List<Object> get props => [nim];
}
