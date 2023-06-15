import 'package:academic_system/src/bloc/khs/khs_bloc.dart';
import 'package:academic_system/src/model/kartu_hasil_studi.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentDetail extends StatefulWidget {
  const StudentDetail({
    Key? key,
    required this.user,
  }) : super(key: key);

  final Student user;

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  @override
  void initState() {
    super.initState();
    // context.read<KhsBloc>().add(GetTranskripEvent(nim: widget.user.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KhsBloc, KhsState>(
      builder: (context, state) {
        if (state is KhsLoading) {
          return const CircularProgressIndicator();
        } else if (state is TranskripLoaded) {
          String ips = state.transkripLengkap.khs
              .where((element) =>
                  element.semester ==
                  (int.tryParse(widget.user.semester)! - 1).toString())
              .toList()[0]
              .ips;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama  : ${widget.user.name}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'NIM   : ${widget.user.id}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Jurusan  : ${widget.user.major}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Semester ${widget.user.semester}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // TODO: Ambil data dari tabel transkrip nilai
                      Text(
                        'IPK : ${state.transkripLengkap.transkripNilai.ipk}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // IPS diambil dari khs sesuai semester
                      Text(
                        'IPS : $ips',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mata Kuliah',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // TODO: Ambil data dari tabel transkrip nilai
                      Text(
                        'Diambil  : ${state.transkripLengkap.transkripNilai.totalKreditDiambil}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Diperoleh : ${state.transkripLengkap.transkripNilai.totalKreditDiperoleh}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
