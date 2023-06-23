part of 'transaksi_bloc.dart';

abstract class TransaksiEvent extends Equatable {
  const TransaksiEvent();

  @override
  List<Object> get props => [];
}

class CreateTransaksi extends TransaksiEvent {
  final String idTagihanPerkuliahan;
  final String nim;
  final String totalTagihan;

  const CreateTransaksi({
    required this.idTagihanPerkuliahan,
    required this.nim,
    required this.totalTagihan,
  });

  @override
  List<Object> get props => [idTagihanPerkuliahan, nim, totalTagihan];
}
