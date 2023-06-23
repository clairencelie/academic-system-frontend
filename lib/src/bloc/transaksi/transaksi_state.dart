part of 'transaksi_bloc.dart';

abstract class TransaksiState extends Equatable {
  const TransaksiState();

  @override
  List<Object> get props => [];
}

class TransaksiInitial extends TransaksiState {}

class TransaksiLoading extends TransaksiState {}

class TransaksiCreated extends TransaksiState {
  final String message;

  const TransaksiCreated({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class TransaksiFailed extends TransaksiState {}
