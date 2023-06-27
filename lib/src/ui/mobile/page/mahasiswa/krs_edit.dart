import 'package:academic_system/src/bloc/khs/khs_bloc.dart';
import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/model/kartu_rencana_studi_lengkap.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/transkrip_lengkap.dart';
import 'package:academic_system/src/ui/mobile/component/custom_widget/list_matkul_edit_krs.dart';
import 'package:academic_system/src/ui/mobile/component/custom_widget/student_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileEditKRSPage extends StatefulWidget {
  final KartuRencanaStudiLengkap krs;
  final Student student;

  const MobileEditKRSPage({
    super.key,
    required this.krs,
    required this.student,
  });

  @override
  State<MobileEditKRSPage> createState() => _MobileEditKRSPageState();
}

class _MobileEditKRSPageState extends State<MobileEditKRSPage> {
  @override
  void initState() {
    super.initState();
    context.read<KrsBloc>().add(GetKrsScheduleForUpdate(
          nim: widget.student.id,
          semester: widget.student.semester,
        ));
    context.read<KhsBloc>().add(GetTranskripEvent(nim: widget.student.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: BlocBuilder<KhsBloc, KhsState>(
                  builder: (context, state) {
                    if (state is TranskripLoaded) {
                      TranksripLengkap tranksripLengkap =
                          state.transkripLengkap;
                      return Column(
                        children: [
                          EditKRSHeader(
                            student: widget.student,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MobileStudentDetail(
                            mahasiswa: widget.student,
                            transkripLengkap: tranksripLengkap,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<KrsBloc, KrsState>(
                            builder: (context, state) {
                              if (state is KrsScheduleLoaded) {
                                return MobileListMatkulEditKRS(
                                  user: widget.student,
                                  krsSchedule: state.krsSchedule,
                                  krs: widget.krs,
                                  tranksripLengkap: tranksripLengkap,
                                );
                              }
                              return const CircularProgressIndicator();
                            },
                          )
                        ],
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditKRSHeader extends StatelessWidget {
  final Student student;
  const EditKRSHeader({
    Key? key,
    required this.student,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          padding: const EdgeInsets.only(right: 15),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          constraints: const BoxConstraints(),
          onPressed: () {
            Navigator.pop(context);
            context.read<KrsBloc>().add(GetKrsLengkap(nim: student.id));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        const Text(
          'Edit KRS',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class EditKRSInfo extends StatelessWidget {
  const EditKRSInfo({
    Key? key,
    required this.student,
    required this.krs,
  }) : super(key: key);

  final Student student;
  final KartuRencanaStudiLengkap krs;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama: ${student.name}',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'NIM: ${student.id}',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Semester: ${krs.semester}',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Program Studi: ${krs.jurusan}',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'IPK: ${krs.ipk}',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'IPS: ${krs.ips}',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Beban Maks SKS: ${int.tryParse(krs.semester)! < 5 ? '20' : krs.bebanSksMaks}',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'T.A Akademik: ${krs.tahunAkademik}',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
