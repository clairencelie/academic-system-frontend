part of 'rincian_tagihan_bloc.dart';

abstract class RincianTagihanState extends Equatable {
  const RincianTagihanState();

  @override
  List<Object> get props => [];
}

class RincianTagihanInitial extends RincianTagihanState {}

class RincianTagihanLoading extends RincianTagihanState {}

class RincianTagihanLoaded extends RincianTagihanState {
  final List<RincianTagihan> listRincianTagihan;

  const RincianTagihanLoaded({
    required this.listRincianTagihan,
  });

  @override
  List<Object> get props => [listRincianTagihan];
}

class RincianTagihanNotFound extends RincianTagihanState {}
