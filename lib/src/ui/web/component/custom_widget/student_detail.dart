import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/transkrip_lengkap.dart';
import 'package:flutter/material.dart';

class StudentDetail extends StatefulWidget {
  const StudentDetail({
    Key? key,
    required this.user,
    required this.transkripLengkap,
  }) : super(key: key);

  final Student user;
  final TranksripLengkap transkripLengkap;

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  @override
  Widget build(BuildContext context) {
    String semesterSebelumnya =
        (int.tryParse(widget.user.semester)! - 1).toString();

    String ips = widget.transkripLengkap.khs.isEmpty
        ? '0'
        : widget.user.semester == '1'
            ? widget.transkripLengkap.khs
                .where((element) => element.semester == widget.user.semester)
                .toList()[0]
                .ips
            : widget.transkripLengkap.khs
                .where((element) => element.semester == semesterSebelumnya)
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
        widget.user.semester == '1'
            ? const Text('Semester 1')
            : Row(
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
                      Text(
                        'IPK : ${widget.transkripLengkap.transkripNilai.ipk}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // IPS diambil dari khs sesuai semester
                      Text(
                        'IPS (Smt $semesterSebelumnya): $ips',
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
                      Text(
                        'Diambil  : ${widget.transkripLengkap.transkripNilai.totalKreditDiambil}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Diperoleh : ${widget.transkripLengkap.transkripNilai.totalKreditDiperoleh}',
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
}
