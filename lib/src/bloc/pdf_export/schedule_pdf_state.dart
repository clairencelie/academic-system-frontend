part of 'schedule_pdf_bloc.dart';

abstract class SchedulePdfState extends Equatable {
  const SchedulePdfState();

  @override
  List<Object> get props => [];
}

class SchedulePdfInitial extends SchedulePdfState {}

class SchedulePdfLoading extends SchedulePdfState {}

class SchedulePdfLoaded extends SchedulePdfState {
  final Uint8List pdf;

  const SchedulePdfLoaded({
    required this.pdf,
  });

  @override
  List<Object> get props => [pdf];
}

class SchedulePdfError extends SchedulePdfState {}

class SchedulePdfMobileLoaded extends SchedulePdfState {
  final List<Schedule> jadwal;

  const SchedulePdfMobileLoaded({
    required this.jadwal,
  });

  @override
  List<Object> get props => [jadwal];
}

class SchedulePdfMobileError extends SchedulePdfState {}
