import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/transkrip_lengkap.dart';
import 'package:flutter/material.dart';

class MobileStudentDetail extends StatefulWidget {
  const MobileStudentDetail({
    Key? key,
    required this.mahasiswa,
    required this.transkripLengkap,
  }) : super(key: key);

  final Student mahasiswa;
  final TranksripLengkap transkripLengkap;

  @override
  State<MobileStudentDetail> createState() => _MobileStudentDetailState();
}

class _MobileStudentDetailState extends State<MobileStudentDetail> {
  @override
  Widget build(BuildContext context) {
    String maxSksFromTranskrip = widget.transkripLengkap.khs.isEmpty
        ? "20"
        : widget.transkripLengkap.khs
            .where((element) =>
                element.semester ==
                (int.tryParse(widget.mahasiswa.semester)! - 1).toString())
            .toList()[0]
            .maskSks;

    int maxSks = int.tryParse(widget.mahasiswa.semester)! <= 4
        ? 20
        : int.tryParse(maxSksFromTranskrip)!;

    String semesterSebelumnya =
        (int.tryParse(widget.mahasiswa.semester)! - 1).toString();

    String ips = widget.transkripLengkap.khs.isEmpty
        ? '0'
        : widget.mahasiswa.semester == '1'
            ? widget.transkripLengkap.khs
                .where(
                    (element) => element.semester == widget.mahasiswa.semester)
                .toList()[0]
                .ips
            : widget.transkripLengkap.khs
                .where((element) => element.semester == semesterSebelumnya)
                .toList()[0]
                .ips;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 32, 96),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 3,
            color: Color.fromARGB(55, 0, 0, 0),
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: Color.fromARGB(105, 234, 234, 234),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.mahasiswa.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.mahasiswa.id,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.mahasiswa.major,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 2,
                          color: Color.fromARGB(105, 234, 234, 234),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Semester ${widget.mahasiswa.semester == '1' ? '1' : semesterSebelumnya}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'IPS',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  ips.length > 3 ? ips.substring(0, 4) : ips,
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  'IPK',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.transkripLengkap.transkripNilai.ipk
                                              .length >
                                          3
                                      ? widget
                                          .transkripLengkap.transkripNilai.ipk
                                          .substring(0, 4)
                                      : widget
                                          .transkripLengkap.transkripNilai.ipk,
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Kredit',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    'Total Diambil',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.transkripLengkap.transkripNilai.totalKreditDiambil
                        .toString(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Total Perolehan',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.transkripLengkap.transkripNilai.totalKreditDiperoleh
                        .toString(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          // TODO: Beban mask sks
          Container(
            padding: const EdgeInsets.only(top: 15),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 2,
                  color: Color.fromARGB(105, 234, 234, 234),
                ),
              ),
            ),
            child: Text(
              'Maksimal SKS diambil: $maxSks',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
