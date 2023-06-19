import 'package:academic_system/src/bloc/khs/khs_bloc.dart';
import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/transkrip_lengkap.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/list_matkul_krs.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/student_detail.dart';
import 'package:academic_system/src/ui/web/page/krs_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class KRSWebPage extends StatefulWidget {
  final User user;
  const KRSWebPage({
    super.key,
    required this.user,
  });

  @override
  State<KRSWebPage> createState() => _KRSWebPageState();
}

class _KRSWebPageState extends State<KRSWebPage> {
  var now = DateTime.now();
  bool isAfterTime = true;
  bool isBeforeTime = true;
  String semester = '';
  String tahunAkademik = '';

  @override
  void initState() {
    super.initState();
    context.read<KrsBloc>().add(GetKrsSchedule(
          nim: widget.user.id,
          semester: (widget.user as Student).semester,
        ));
    context.read<KhsBloc>().add(GetTranskripEvent(nim: widget.user.id));
  }

  @override
  Widget build(BuildContext context) {
    String formattedDateNow = DateFormat('dd-MM-yyyy').format(now);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: BlocBuilder<KhsBloc, KhsState>(
            builder: (context, state) {
              if (state is TranskripLoaded) {
                TranksripLengkap tranksripLengkap = state.transkripLengkap;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kartu Rencana Studi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    StudentDetail(
                      user: (widget.user as Student),
                      transkripLengkap: tranksripLengkap,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    (widget.user as Student).semester == '1'
                        ? const SizedBox()
                        : TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return KrsHistoryPage(
                                      student: (widget.user as Student),
                                    );
                                  },
                                ),
                              );
                            },
                            child: const Text(
                                'Lihat histori pengisian KRS mu disini'),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<KrsBloc, KrsState>(
                      builder: (context, state) {
                        if (state is AlreadyFillKrs) {
                          return Center(
                            child: Text(state.message),
                          );
                        } else if (state is KrsScheduleLoaded) {
                          semester = state.krsSchedule.semester;
                          tahunAkademik = state.krsSchedule.tahunAkademik;

                          isAfterTime = DateFormat('dd-MM-yyyy')
                              .parse(formattedDateNow)
                              .isAfter(DateFormat('dd-MM-yyyy')
                                  .parse(state.krsSchedule.tanggalSelesai));
                          isBeforeTime = DateFormat('dd-MM-yyyy')
                              .parse(formattedDateNow)
                              .isBefore(DateFormat('dd-MM-yyyy')
                                  .parse(state.krsSchedule.tanggalMulai));

                          // print(isBeforeTime);
                          // print(isAfterTime);

                          return (!isBeforeTime && !isAfterTime)
                              ? ListMatkulKRS(
                                  user: (widget.user as Student),
                                  tranksripLengkap: tranksripLengkap,
                                  krsSchedule: state.krsSchedule,
                                )
                              : const Text(
                                  'Pengisian KRS untuk semester selanjutnya belum dimulai',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                        } else if (state is KrsLoading) {
                          return const CircularProgressIndicator();
                        }
                        return const Text(
                          'Pengisian KRS untuk semester selanjutnya belum dimulai',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
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
