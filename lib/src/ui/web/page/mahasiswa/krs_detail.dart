import 'package:academic_system/src/bloc/schedule_krs/schedule_krs_bloc.dart';
import 'package:academic_system/src/helper/date_converter.dart';
import 'package:academic_system/src/model/kartu_rencana_studi_lengkap.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/ui/web/page/mahasiswa/krs_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class KRSDetailPage extends StatefulWidget {
  final KartuRencanaStudiLengkap krs;
  final Student student;

  const KRSDetailPage({
    super.key,
    required this.krs,
    required this.student,
  });

  @override
  State<KRSDetailPage> createState() => _KRSDetailPageState();
}

class _KRSDetailPageState extends State<KRSDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<ScheduleKrsBloc>().add(GetScheduleKrs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const KRSDetailHeader(),
                  const SizedBox(
                    height: 20,
                  ),
                  KRSDetailInfo(student: widget.student, krs: widget.krs),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'List Mata Kuliah Dipilih',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      BlocBuilder<ScheduleKrsBloc, ScheduleKrsState>(
                        builder: (context, state) {
                          if (state is ScheduleKrsLoaded) {
                            String formattedDateNow =
                                DateFormat('dd-MM-yyyy').format(DateTime.now());
                            return ElevatedButton(
                              onPressed: widget.krs.commit == '1' ||
                                      DateFormat('dd-MM-yyyy')
                                          .parse(formattedDateNow)
                                          .isAfter(DateFormat('dd-MM-yyyy')
                                              .parse(state
                                                  .krsSchedule.tanggalSelesai))
                                  ? null
                                  : widget.krs.approve == '1'
                                      ? null
                                      : () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return EditKRSPage(
                                                  krs: widget.krs,
                                                  student: widget.student,
                                                );
                                              },
                                            ),
                                          );
                                        },
                              child: const Text('Ubah pilihan mata kuliah'),
                            );
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  const PilihanMatkulHeader(),

                  const Divider(),

                  // List Matkul yang diambil
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.krs.pilihanMataKuliah.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 15),
                        height: 70,
                        decoration: BoxDecoration(
                          color: index % 2 == 1
                              ? const Color.fromARGB(255, 251, 251, 251)
                              : const Color.fromARGB(255, 245, 247, 251),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 1,
                              color: Color.fromARGB(55, 0, 0, 0),
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Center(
                          child: ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(widget
                                      .krs.pilihanMataKuliah[index].idMatkul),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                      widget.krs.pilihanMataKuliah[index].name),
                                ),
                                Expanded(
                                  child: Text(widget
                                      .krs.pilihanMataKuliah[index].credit),
                                ),
                                Expanded(
                                  child: Text(widget
                                      .krs.pilihanMataKuliah[index].grade),
                                ),
                                Expanded(
                                  child: Text(widget
                                      .krs.pilihanMataKuliah[index].type
                                      .toUpperCase()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class KRSDetailInfo extends StatelessWidget {
  const KRSDetailInfo({
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
            const SizedBox(
              height: 5,
            ),
            Text(
              'NIM: ${student.id}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Semester: ${krs.semester}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
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
            const SizedBox(
              height: 5,
            ),
            Text(
              'IPS: ${krs.ips}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Kredit Diambil: ${krs.kreditDiambil}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
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
              'Tanggal Pengisian KRS: ${DateConverter.mySQLToDartDateFormat(krs.waktuPengisian)}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'T.A Akademik: ${krs.tahunAkademik}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Approval: ${krs.approve == '1' ? "Diapprove" : "Belum diapprove"}',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Status KRS: ${krs.commit == '1' ? "Dikunci" : "Belum dikunci"}',
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

class KRSDetailHeader extends StatelessWidget {
  const KRSDetailHeader({
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
          'Detail Kartu Rencana Studi',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class PilihanMatkulHeader extends StatelessWidget {
  const PilihanMatkulHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: ListTile(
          title: Row(
            children: const [
              Expanded(
                child: Text(
                  'Kode MK',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Nama MK',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'SKS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Kelas',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Jenis',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
