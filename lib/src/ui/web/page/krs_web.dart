import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/helper/date_converter.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/list_matkul_krs.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/list_matkul_krs_header.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/student_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class KRSWebPage extends StatefulWidget {
  final Student user;
  const KRSWebPage({
    super.key,
    required this.user,
  });

  @override
  State<KRSWebPage> createState() => _KRSWebPageState();
}

class _KRSWebPageState extends State<KRSWebPage> {
  var now = DateTime.now();

  // bool isSameTimeStart = false;
  // bool isSameTimeEnd = false;
  bool isAfterTime = true;
  bool isBeforeTime = true;

  @override
  void initState() {
    super.initState();
    context.read<KrsBloc>().add(GetKrsSchedule());
  }

  @override
  Widget build(BuildContext context) {
    String formattedDateNow = DateFormat('dd-MM-yyyy').format(now);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              StudentDetail(user: widget.user),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pengisian KRS',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  BlocBuilder<KrsBloc, KrsState>(
                    builder: (context, state) {
                      if (state is KrsScheduleLoaded) {
                        return Text(
                          '${DateConverter.convertToDartDateFormat(state.krsSchedule.tanggalMulai)} - ${DateConverter.convertToDartDateFormat(state.krsSchedule.tanggalSelesai)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else if (state is KrsScheduleNotFound) {
                        return const Text(
                          '-',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
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
              const ListMatkulKrsHeader(),
              const Divider(),
              BlocBuilder<KrsBloc, KrsState>(
                builder: (context, state) {
                  if (state is KrsScheduleLoaded) {
                    isAfterTime = DateFormat('dd-MM-yyyy')
                        .parse(formattedDateNow)
                        .isAfter(DateFormat('dd-MM-yyyy')
                            .parse(state.krsSchedule.tanggalSelesai));
                    isBeforeTime = DateFormat('dd-MM-yyyy')
                        .parse(formattedDateNow)
                        .isBefore(DateFormat('dd-MM-yyyy')
                            .parse(state.krsSchedule.tanggalMulai));

                    print(isBeforeTime);
                    print(isAfterTime);

                    return (!isBeforeTime && !isAfterTime)
                        ? ListMatkulKRS(user: widget.user)
                        : const Text(
                            'Pengisian KRS untuk semester selanjutnya belum dimulai',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
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
          ),
        ),
      ),
    );
  }
}
