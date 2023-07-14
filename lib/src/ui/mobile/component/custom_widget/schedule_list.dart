import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/bloc/schedule/schedule_bloc.dart';
import 'package:academic_system/src/helper/ina_day.dart';
import 'package:academic_system/src/model/kartu_rencana_studi_lengkap.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/lecturer.dart';
import 'package:academic_system/src/model/schedule.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/mobile/component/card/daily_schedule_card.dart';
import 'package:academic_system/src/ui/mobile/component/custom_widget/no_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleList extends StatefulWidget {
  final KrsSchedule krsSchedule;

  final User user;

  const ScheduleList({
    Key? key,
    required this.user,
    required this.krsSchedule,
  }) : super(key: key);

  @override
  State<ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  @override
  Widget build(BuildContext context) {
    return ScheduleBody(
      krsSchedule: widget.krsSchedule,
      user: widget.user,
    );
  }
}

class ScheduleBody extends StatefulWidget {
  final KrsSchedule krsSchedule;
  final User user;

  const ScheduleBody({
    Key? key,
    required this.krsSchedule,
    required this.user,
  }) : super(key: key);

  @override
  State<ScheduleBody> createState() => _ScheduleBodyState();
}

class _ScheduleBodyState extends State<ScheduleBody> {
  @override
  void initState() {
    super.initState();

    if (widget.user is Student) {
      context.read<KrsBloc>().add(
            GetKrsSmtIni(
              nim: widget.user.id,
              tahunAkademik: widget.krsSchedule.tahunAkademik,
              semester: (widget.user as Student).semester,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KrsBloc, KrsState>(
      builder: (context, state) {
        if (widget.user is Student) {
          if (state is KrsSmtIniFound) {
            return MobileScheduleList(
              user: widget.user,
              krsLengkap: state.krsLengkap,
              krsSchedule: widget.krsSchedule,
            );
          } else if (state is KrsSmtIniNotFound) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Jadwal Hari Ini',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2.25,
                    child: const Center(
                      child: Text(
                        'Anda Belum Melakukan Pengisian KRS',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        } else if (widget.user is Lecturer) {
          return MobileScheduleList(
            user: widget.user,
            krsSchedule: widget.krsSchedule,
          );
        }
        return MobileScheduleList(
          krsSchedule: widget.krsSchedule,
        );
      },
    );
  }
}

class MobileScheduleList extends StatefulWidget {
  final KartuRencanaStudiLengkap? krsLengkap;
  final User? user;
  final KrsSchedule krsSchedule;

  const MobileScheduleList({
    Key? key,
    this.krsLengkap,
    this.user,
    required this.krsSchedule,
  }) : super(key: key);

  @override
  State<MobileScheduleList> createState() => _MobileScheduleListState();
}

class _MobileScheduleListState extends State<MobileScheduleList> {
  void callScheduleBloc() {
    if (widget.user is Student) {
      context.read<ScheduleBloc>().add(RequestStudentSchedules(
            id: widget.krsLengkap!.nim,
            idKrs: widget.krsLengkap!.id,
            day: InaDay.getDayName(),
            tahunAkademik: widget.krsLengkap!.tahunAkademik,
            semester: int.tryParse(widget.krsLengkap!.semester)! % 2 == 0
                ? 'genap'
                : 'ganjil',
          ));
    } else if (widget.user is Lecturer) {
      context.read<ScheduleBloc>().add(RequestLecturerSchedules(
            id: widget.user!.id,
            day: InaDay.getDayName(),
            tahunAkademik: widget.krsSchedule.tahunAkademik,
            semester: widget.krsSchedule.semester,
          ));
    } else {
      context.read<ScheduleBloc>().add(RequestAllSchedule(
            tahunAkademik: widget.krsSchedule.tahunAkademik,
            semester: widget.krsSchedule.semester,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    callScheduleBloc();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Jadwal Hari Ini',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {
                callScheduleBloc();
              },
              icon: const Icon(Icons.replay_outlined),
            ),
          ],
        ),
        BlocBuilder<ScheduleBloc, ScheduleState>(
          builder: (context, state) {
            if (state is ScheduleInitial || state is RequestingSchedule) {
              return const SizedBox(
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 0, 32, 96),
                  ),
                ),
              );
            } else if (state is ScheduleLoaded) {
              List<Schedule> schedules = state.schedules;

              List<Schedule> schedulesByDay = schedules
                  .where((element) => element.day == InaDay.getDayName())
                  .toList();

              if (schedules.isNotEmpty) {
                if (schedulesByDay.isEmpty) {
                  return const NoSchedule();
                }
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return DailyScheduleCard(schedule: schedulesByDay[index]);
                  },
                  itemCount: schedulesByDay.length,
                );
              }
            } else if (state is ScheduleEmpty) {
              return const NoSchedule();
            } else if (state is ScheduleRequestFailed) {
              return const Text(
                  'Gagal mendapatkan data jadwal, mohon klik icon refresh');
            }
            return const NoSchedule();
          },
        ),
      ],
    );
  }
}
