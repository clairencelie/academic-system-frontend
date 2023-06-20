import 'package:academic_system/src/bloc/khs/khs_bloc.dart';
import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/model/kartu_rencana_studi_lengkap.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/transkrip_lengkap.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/list_matkul_edit_krs.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/list_matkul_krs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditKRSPage extends StatefulWidget {
  final KartuRencanaStudiLengkap krs;
  final Student student;

  const EditKRSPage({
    super.key,
    required this.krs,
    required this.student,
  });

  @override
  State<EditKRSPage> createState() => _EditKRSPageState();
}

class _EditKRSPageState extends State<EditKRSPage> {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: BlocBuilder<KhsBloc, KhsState>(
            builder: (context, state) {
              if (state is TranskripLoaded) {
                TranksripLengkap tranksripLengkap = state.transkripLengkap;
                return Column(
                  children: [
                    const EditKRSHeader(),
                    const SizedBox(
                      height: 20,
                    ),
                    EditKRSInfo(student: widget.student, krs: widget.krs),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<KrsBloc, KrsState>(
                      builder: (context, state) {
                        if (state is KrsScheduleLoaded) {
                          return ListMatkulEditKRS(
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
    );
  }
}

class EditKRSHeader extends StatelessWidget {
  const EditKRSHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
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
        Column(
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
        Column(
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
        Column(
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
      ],
    );
  }
}
