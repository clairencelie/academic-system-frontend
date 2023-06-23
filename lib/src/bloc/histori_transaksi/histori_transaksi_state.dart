part of 'histori_transaksi_bloc.dart';

abstract class HistoriTransaksiState extends Equatable {
  const HistoriTransaksiState();

  @override
  List<Object> get props => [];
}

class HistoriTransaksiInitial extends HistoriTransaksiState {}

class HistoriTransaksiLoading extends HistoriTransaksiState {}

class AllHistoriTransaksiLoaded extends HistoriTransaksiState {
  final List<HistoriTransaksi> listHistoriTransaksi;

  const AllHistoriTransaksiLoaded({
    required this.listHistoriTransaksi,
  });

  @override
  List<Object> get props => [listHistoriTransaksi];
}

class HistoriTransaksiNotFound extends HistoriTransaksiState {}
