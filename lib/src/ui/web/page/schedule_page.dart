import 'package:academic_system/src/bloc/schedule/schedule_bloc.dart';
import 'package:academic_system/src/helper/ina_day.dart';
import 'package:academic_system/src/model/lecturer.dart';
import 'package:academic_system/src/model/schedule.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/web/component/custom_widget/no_schedule.dart';
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
    if (widget.user is Student) {
      context.read<ScheduleBloc>().add(RequestStudentSchedules(
            id: widget.user.id,
            day: InaDay.getDayName(),
          ));
    } else if (widget.user is Lecturer) {
      context.read<ScheduleBloc>().add(RequestLecturerSchedules(
            id: widget.user.id,
            day: InaDay.getDayName(),
          ));
    } else {
      context.read<ScheduleBloc>().add(RequestSchedulesByDay(
            day: InaDay.getDayName(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Jadwal Hari Ini',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              WebDailyScheduleList(scrollController: scrollController),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Jadwal Ujian',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const WebNoSchedule(),
              const Text(
                'Jadwal Sidang',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const WebNoSchedule(),
            ],
          ),
        ),
      ),
    );
  }
}

class WebDailyScheduleList extends StatelessWidget {
  const WebDailyScheduleList({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

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
          if (schedules.isNotEmpty) {
            return SizedBox(
              height: 240,
              child: Scrollbar(
                controller: scrollController,
                interactive: true,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ListView.builder(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return WebDailyScheduleCard(schedule: schedules[index]);
                    },
                    itemCount: schedules.length,
                  ),
                ),
              ),
            );
          }
        } else if (state is ScheduleEmpty) {
          return const WebNoSchedule();
        } else if (state is ScheduleRequestFailed) {}
        return const WebNoSchedule();
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
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 20, right: 10),
      height: 100,
      width: 300,
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
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            schedule.learningSubName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Pengajar:",
            style: TextStyle(
              fontSize: 16,
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
              fontSize: 16,
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
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            schedule.grade,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 16,
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
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const Text(
                ' - ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                schedule.endsAt,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
