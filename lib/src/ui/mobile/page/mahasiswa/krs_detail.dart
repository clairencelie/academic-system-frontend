import 'package:academic_system/src/bloc/schedule_krs/schedule_krs_bloc.dart';
import 'package:academic_system/src/model/kartu_rencana_studi_lengkap.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/ui/mobile/page/mahasiswa/krs_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MobileKRSDetailPage extends StatefulWidget {
  final KartuRencanaStudiLengkap krs;
  final Student student;

  const MobileKRSDetailPage({
    super.key,
    required this.krs,
    required this.student,
  });

  @override
  State<MobileKRSDetailPage> createState() => _MobileKRSDetailPageState();
}

class _MobileKRSDetailPageState extends State<MobileKRSDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<ScheduleKrsBloc>().add(GetScheduleKrs());
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const KRSDetailHeader(),
                    const SizedBox(
                      height: 20,
                    ),
                    KRSDetailInfo(student: widget.student, krs: widget.krs),
                    Container(
                      alignment: Alignment.centerRight,
                      child: ButtonPengajuanPerubahanKrs(
                        krs: widget.krs,
                        mahasiswa: widget.student,
                      ),
                    ),
                    const Text(
                      'List Mata Kuliah Dipilih',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // List Matkul yang diambil
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.krs.pilihanMataKuliah.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 15),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.krs.pilihanMataKuliah[index].id,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    widget.krs.pilihanMataKuliah[index].grade,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                widget.krs.pilihanMataKuliah[index].name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Jumlah SKS: ${widget.krs.pilihanMataKuliah[index].credit}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                // '${widget.krs.pilihanMataKuliah[index].type[0].toUpperCase()}${widget.krs.pilihanMataKuliah[index].type.substring(1)}',
                                widget.krs.pilihanMataKuliah[index].type
                                    .toUpperCase(),
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
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
      ),
    );
  }
}

class ButtonPengajuanPerubahanKrs extends StatelessWidget {
  const ButtonPengajuanPerubahanKrs({
    Key? key,
    required this.krs,
    required this.mahasiswa,
  }) : super(key: key);

  final KartuRencanaStudiLengkap krs;
  final Student mahasiswa;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleKrsBloc, ScheduleKrsState>(
      builder: (context, state) {
        if (state is ScheduleKrsLoaded) {
          String formattedDateNow =
              DateFormat('dd-MM-yyyy').format(DateTime.now());
          return ElevatedButton(
            onPressed: krs.commit == '1' ||
                    DateFormat('dd-MM-yyyy').parse(formattedDateNow).isAfter(
                        DateFormat('dd-MM-yyyy')
                            .parse(state.krsSchedule.tanggalSelesai))
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MobileEditKRSPage(
                            krs: krs,
                            student: mahasiswa,
                          );
                        },
                      ),
                    );
                  },
            child: const Text('Ajukan Perubahan KRS'),
          );
        }
        return const CircularProgressIndicator();
      },
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
    return Column(
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
          'Kredit Diambil: ${krs.kreditDiambil}',
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
        Text(
          'Tanggal Pengisian KRS: ${krs.waktuPengisian}',
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'T.A Akademik: ${krs.tahunAkademik}',
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Status KRS: ${krs.commit == '1' ? "Dikunci" : "Belum dikunci"}',
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
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
          padding: const EdgeInsets.only(right: 15),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          constraints: const BoxConstraints(),
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
