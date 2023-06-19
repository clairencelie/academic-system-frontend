import 'package:academic_system/src/model/transkrip_lengkap.dart';
import 'package:academic_system/src/repository/khs_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'khs_event.dart';
part 'khs_state.dart';

class KhsBloc extends Bloc<KhsEvent, KhsState> {
  final KhsRepository repository;

  KhsBloc({required this.repository}) : super(KhsInitial()) {
    on<GetTranskripEvent>((event, emit) async {
      emit(KhsLoading());

      TranksripLengkap? transkripLengkap =
          await repository.getTranskrip(event.nim);

      if (transkripLengkap != null) {
        print(transkripLengkap.transkripNilai);
        print(transkripLengkap.khs);
        emit(TranskripLoaded(transkripLengkap: transkripLengkap));
      } else {
        emit(TranskripFailed());
      }
    });
  }
}
