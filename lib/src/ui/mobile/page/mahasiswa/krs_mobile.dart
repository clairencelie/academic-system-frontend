import 'package:academic_system/src/bloc/khs/khs_bloc.dart';
import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/bloc/tagihan/tagihan_perkuliahan_bloc.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/transkrip_lengkap.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/mobile/component/custom_widget/list_matkul_krs.dart';
import 'package:academic_system/src/ui/mobile/component/custom_widget/student_detail.dart';
import 'package:academic_system/src/ui/mobile/page/mahasiswa/krs_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MobileKRSPage extends StatefulWidget {
  final User user;
  const MobileKRSPage({
    super.key,
    required this.user,
  });

  @override
  State<MobileKRSPage> createState() => _MobileKRSPageState();
}

class _MobileKRSPageState extends State<MobileKRSPage> {
  var now = DateTime.now();
  bool isAfterTime = true;
  bool isBeforeTime = true;
  String semester = '';
  String tahunAkademik = '';

  @override
  void initState() {
    super.initState();
    context.read<KrsBloc>().add(
          GetKrsSchedule(
            nim: widget.user.id,
            semester: (widget.user as Student).semester,
          ),
        );

    context.read<KhsBloc>().add(
          GetTranskripEvent(nim: widget.user.id),
        );

    context.read<TagihanPerkuliahanBloc>().add(
          GetListTagihan(nim: widget.user.id),
        );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDateNow = DateFormat('dd-MM-yyyy').format(now);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const HeaderKrsMobile(),
                          Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MobileKrsHistoryPage(
                                        student: (widget.user as Student),
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.blue, width: 1),
                                    ),
                                  ),
                                  child: const Text(
                                    'Histori Pengisian KRS',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<KrsBloc, KrsState>(
                            builder: (context, state) {
                              if (state is AlreadyFillKrs) {
                                return Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        2.5,
                                    child: Center(
                                      child: Text(
                                        state.message,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 189, 189, 189),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else if (state is KrsScheduleLoaded) {
                                semester = state.krsSchedule.semester;
                                tahunAkademik = state.krsSchedule.tahunAkademik;
                                var krsSchedule = state.krsSchedule;

                                isAfterTime = DateFormat('dd-MM-yyyy')
                                    .parse(formattedDateNow)
                                    .isAfter(DateFormat('dd-MM-yyyy').parse(
                                        state.krsSchedule.tanggalSelesai));
                                isBeforeTime = DateFormat('dd-MM-yyyy')
                                    .parse(formattedDateNow)
                                    .isBefore(DateFormat('dd-MM-yyyy')
                                        .parse(state.krsSchedule.tanggalMulai));

                                return (!isBeforeTime && !isAfterTime)
                                    ? BlocBuilder<TagihanPerkuliahanBloc,
                                        TagihanPerkuliahanState>(
                                        builder: (context, state) {
                                          if (state
                                              is TagihanPerkuliahanLoaded) {
                                            var listTagihan = state.listTagihan;

                                            var tunggakanSemester = listTagihan
                                                .where(
                                                  (tagihan) =>
                                                      tagihan.kategori.contains(
                                                          'Semester') &&
                                                      tagihan.statusPembayaran ==
                                                          'belum_bayar' &&
                                                      ((tagihan.tahunAkademik !=
                                                                  krsSchedule
                                                                      .tahunAkademik &&
                                                              tagihan.semester !=
                                                                  krsSchedule
                                                                      .semester) ||
                                                          (tagihan.tahunAkademik ==
                                                                  krsSchedule
                                                                      .tahunAkademik &&
                                                              tagihan.semester !=
                                                                  krsSchedule
                                                                      .semester)),
                                                )
                                                .toList();

                                            var tunggakanDPKrs = listTagihan
                                                .where(
                                                    (tagihan) =>
                                                        tagihan.kategori ==
                                                            'Uang Muka Pengisian KRS' &&
                                                        tagihan.statusPembayaran ==
                                                            'belum_bayar' &&
                                                        tagihan.tahunAkademik ==
                                                            krsSchedule
                                                                .tahunAkademik &&
                                                        tagihan.semester ==
                                                            krsSchedule
                                                                .semester)
                                                .toList();

                                            if (tunggakanSemester.isEmpty &&
                                                tunggakanDPKrs.isEmpty) {
                                              return Column(
                                                children: [
                                                  MobileStudentDetail(
                                                    mahasiswa:
                                                        widget.user as Student,
                                                    transkripLengkap:
                                                        tranksripLengkap,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  MobileListMatkulKRS(
                                                    user: (widget.user
                                                        as Student),
                                                    tranksripLengkap:
                                                        tranksripLengkap,
                                                    krsSchedule: krsSchedule,
                                                  ),
                                                ],
                                              );
                                            }
                                            return SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  2,
                                              child: const Center(
                                                child: Text(
                                                  'Maaf, anda belum memenuhi persyaratan untuk pengisian KRS.\nMohon cek halaman tagihan dan pastikan tidak ada tunggakan pembayaran semester sebelumnya dan sudah melunasi uang muka pengisian KRS',
                                                ),
                                              ),
                                            );
                                          }
                                          return SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            child: const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        },
                                      )
                                    : SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        child: const Center(
                                          child: Text(
                                            'Pengisian KRS Untuk Semester Selanjutnya Belum Dimulai',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      );
                              } else if (state is KrsLoading) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              return SizedBox(
                                height: MediaQuery.of(context).size.height / 4,
                                child: const Center(
                                  child: Text(
                                    'Pengisian KRS Untuk Semester Selanjutnya Belum Dimulai',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
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

class HeaderKrsMobile extends StatelessWidget {
  const HeaderKrsMobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          // padding: const EdgeInsets.only(right: 15),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          constraints: const BoxConstraints(),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        const Text(
          'Kartu Rencana Studi',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
