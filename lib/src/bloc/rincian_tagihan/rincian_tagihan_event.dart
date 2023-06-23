part of 'rincian_tagihan_bloc.dart';

abstract class RincianTagihanEvent extends Equatable {
  const RincianTagihanEvent();

  @override
  List<Object> get props => [];
}

class GetListRincianTagihan extends RincianTagihanEvent {
  final String idTagihanPembayaran;

  const GetListRincianTagihan({
    required this.idTagihanPembayaran,
  });

  @override
  List<Object> get props => [idTagihanPembayaran];
}
