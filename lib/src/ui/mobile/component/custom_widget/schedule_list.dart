import 'package:academic_system/src/bloc/schedule/schedule_bloc.dart';
import 'package:academic_system/src/helper/ina_day.dart';
import 'package:academic_system/src/model/lecturer.dart';
import 'package:academic_system/src/model/schedule.dart';
import 'package:academic_system/src/model/student.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/mobile/component/card/daily_schedule_card.dart';
import 'package:academic_system/src/ui/mobile/component/custom_widget/no_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleList extends StatefulWidget {
  final User user;

  const ScheduleList({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              },
              icon: const Icon(Icons.replay_outlined),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
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
              if (schedules.isNotEmpty) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return DailyScheduleCard(schedule: schedules[index]);
                  },
                  itemCount: schedules.length,
                );
              }
            } else if (state is ScheduleEmpty) {
              return const NoSchedule();
            } else if (state is ScheduleRequestFailed) {
              print(state.message);
            }
            return const NoSchedule();
          },
        ),
      ],
    );
  }
}
