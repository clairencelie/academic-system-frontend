import 'package:academic_system/src/bloc/krs/krs_bloc.dart';
import 'package:academic_system/src/bloc/schedule/schedule_bloc.dart';
import 'package:academic_system/src/bloc/schedule_krs/schedule_krs_bloc.dart';
import 'package:academic_system/src/constant/colors.dart';
import 'package:academic_system/src/helper/ina_day.dart';
import 'package:academic_system/src/model/kartu_rencana_studi_lengkap.dart';
import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/lecturer.dart';
import 'package:academic_system/src/model/schedule.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/no_schedule.dart';
import 'package:academic_system/src/ui/web/page/all_schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebSchedulePage extends StatefulWidget {
  final User user;

  const WebSchedulePage({super.key, required this.user});

  @override
  State<WebSchedulePage> createState() => _WebSchedulePageState();
}

class _WebSchedulePageState extends State<WebSchedulePage> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    context.read<ScheduleKrsBloc>().add(GetScheduleKrs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.7,
              child: BlocBuilder<ScheduleKrsBloc, ScheduleKrsState>(
                builder: (context, state) {
                  if (state is ScheduleKrsLoaded) {
                    return ScheduleBody(
                      scrollController: scrollController,
                      krsSchedule: state.krsSchedule,
                      user: widget.user,
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ScheduleBody extends StatefulWidget {
  final KrsSchedule krsSchedule;
  final User user;

  const ScheduleBody({
    Key? key,
    required this.scrollController,
    required this.krsSchedule,
    required this.user,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  State<ScheduleBody> createState() => _ScheduleBodyState();
}

class _ScheduleBodyState extends State<ScheduleBody> {
  @override
  void initState() {
    super.initState();

    if (widget.user is Student) {
      context.read<KrsBloc>().add(
            GetKrsLengkap(nim: widget.user.id),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Jadwal Perkuliahan Hari Ini - ${InaDay.getDayName()}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'T.A ${widget.krsSchedule.tahunAkademik} - ${widget.krsSchedule.semester[0].toUpperCase()}${widget.krsSchedule.semester.substring(1)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Anda dapat melihat jadwal perkuliahan lengkap T.A ${widget.krsSchedule.tahunAkademik} - ${widget.krsSchedule.semester[0].toUpperCase()}${widget.krsSchedule.semester.substring(1)} disini: ',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => mainColor),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AllSchedulePage(krsSchedule: widget.krsSchedule);
                  },
                ),
              );
            },
            child: Text(
              'Jadwal Perkuliahan Lengkap T.A ${widget.krsSchedule.tahunAkademik} - ${widget.krsSchedule.semester[0].toUpperCase()}${widget.krsSchedule.semester.substring(1)}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Berikut dibawah ini adalah jadwal perkuliahan untuk hari ini :',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        widget.user is Student
            ? BlocBuilder<KrsBloc, KrsState>(
                builder: (context, state) {
                  if (state is KrsFound) {
                    var krsSmtIni = state.krsLengkap
                        .where((element) =>
                            element.tahunAkademik ==
                                widget.krsSchedule.tahunAkademik &&
                            element.semester ==
                                (widget.user as Student).semester)
                        .first;

                    return StudentWebDailyScheduleList(
                      krsLengkap: krsSmtIni,
                    );
                  } else if (state is KrsNotFound) {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          'Anda Belum Melakukan Pengisian KRS',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              )
            : widget.user is Lecturer
                ? LecturerWebDailyScheduleList(
                    dosen: widget.user as Lecturer,
                    krsSchedule: widget.krsSchedule,
                  )
                : WebDailyScheduleList(
                    krsSchedule: widget.krsSchedule,
                  ),
      ],
    );
  }
}

class StudentWebDailyScheduleList extends StatefulWidget {
  final KartuRencanaStudiLengkap krsLengkap;

  const StudentWebDailyScheduleList({
    Key? key,
    required this.krsLengkap,
  }) : super(key: key);

  @override
  State<StudentWebDailyScheduleList> createState() =>
      _StudentWebDailyScheduleListState();
}

class _StudentWebDailyScheduleListState
    extends State<StudentWebDailyScheduleList> {
  @override
  void initState() {
    super.initState();

    context.read<ScheduleBloc>().add(RequestStudentSchedules(
          id: widget.krsLengkap.nim,
          idKrs: widget.krsLengkap.id,
          day: InaDay.getDayName(),
          tahunAkademik: widget.krsLengkap.tahunAkademik,
          semester: int.tryParse(widget.krsLengkap.semester)! % 2 == 0
              ? 'genap'
              : 'ganjil',
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
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

          return schedulesByDay.isEmpty
              ? const WebNoSchedule()
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return WebDailyScheduleCard(
                        schedule: schedulesByDay[index]);
                  },
                  itemCount: schedulesByDay.length,
                );
        } else if (state is ScheduleEmpty) {
          return const WebNoSchedule();
        } else if (state is ScheduleRequestFailed) {
          return const Text(
              'Jadwal Gagal Didapatkan, mohon refresh halaman ini.');
        }
        return const SizedBox(
          height: 300,
          child: Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 0, 32, 96),
            ),
          ),
        );
      },
    );
  }
}

class LecturerWebDailyScheduleList extends StatefulWidget {
  final Lecturer dosen;
  final KrsSchedule krsSchedule;

  const LecturerWebDailyScheduleList({
    Key? key,
    required this.dosen,
    required this.krsSchedule,
  }) : super(key: key);

  @override
  State<LecturerWebDailyScheduleList> createState() =>
      _LecturerWebDailyScheduleListState();
}

class _LecturerWebDailyScheduleListState
    extends State<LecturerWebDailyScheduleList> {
  @override
  void initState() {
    super.initState();

    context.read<ScheduleBloc>().add(RequestLecturerSchedules(
          id: widget.dosen.id,
          day: InaDay.getDayName(),
          tahunAkademik: widget.krsSchedule.tahunAkademik,
          semester: widget.krsSchedule.semester,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
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

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return WebDailyScheduleCard(schedule: schedules[index]);
            },
            itemCount: schedules.length,
          );
        } else if (state is ScheduleEmpty) {
          return const WebNoSchedule();
        } else if (state is ScheduleRequestFailed) {
          return const Text(
              'Jadwal Gagal Didapatkan, mohon refresh halaman ini.');
        }
        return const SizedBox(
          height: 300,
          child: Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 0, 32, 96),
            ),
          ),
        );
      },
    );
  }
}

class WebDailyScheduleList extends StatefulWidget {
  final KrsSchedule krsSchedule;

  const WebDailyScheduleList({
    Key? key,
    required this.krsSchedule,
  }) : super(key: key);

  @override
  State<WebDailyScheduleList> createState() => _WebDailyScheduleListState();
}

class _WebDailyScheduleListState extends State<WebDailyScheduleList> {
  @override
  void initState() {
    super.initState();

    context.read<ScheduleBloc>().add(RequestAllSchedule(
          tahunAkademik: widget.krsSchedule.tahunAkademik,
          semester: widget.krsSchedule.semester,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleBloc, ScheduleState>(
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

          return schedulesByDay.isEmpty
              ? const WebNoSchedule()
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return WebDailyScheduleCard(
                        schedule: schedulesByDay[index]);
                  },
                  itemCount: schedulesByDay.length,
                );
        } else if (state is ScheduleEmpty) {
          return const WebNoSchedule();
        } else if (state is ScheduleRequestFailed) {
          return const Text(
              'Data Jadwal Gagal Didapatkan, mohon refresh halaman ini.');
        }
        return const SizedBox(
          height: 300,
          child: Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 0, 32, 96),
            ),
          ),
        );
      },
    );
  }
}

class WebDailyScheduleCard extends StatelessWidget {
  const WebDailyScheduleCard({
    Key? key,
    required this.schedule,
  }) : super(key: key);

  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 10),
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
          Text(
            '${schedule.learningSubName} - ${schedule.grade}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Pengajar :",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            schedule.lecturerName,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            schedule.room,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                schedule.startsAt,
                style: const TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                ' - ',
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                schedule.endsAt,
                style: const TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
