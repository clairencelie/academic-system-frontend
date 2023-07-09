import 'package:academic_system/src/bloc/schedule_krs/schedule_krs_bloc.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/mobile/component/card/all_schedule_card.dart';
import 'package:academic_system/src/ui/mobile/component/custom_widget/schedule_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulePage extends StatefulWidget {
  final User user;

  const SchedulePage({super.key, required this.user});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  void initState() {
    super.initState();
    context.read<ScheduleKrsBloc>().add(GetScheduleKrs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Judul 1
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const Text(
                        'Jadwal Perkuliahan',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<ScheduleKrsBloc, ScheduleKrsState>(
                    builder: (context, state) {
                      if (state is ScheduleKrsLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AllScheduleCard(
                              krsSchedule: state.krsSchedule,
                              user: widget.user,
                            ),
                            ScheduleList(
                              user: widget.user,
                              krsSchedule: state.krsSchedule,
                            ),
                          ],
                        );
                      } else if (state is ScheduleKrsFailed) {
                        return const Text(
                            'gagal mendapatkan data tahun akademik');
                      }
                      return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child:
                              const Center(child: CircularProgressIndicator()));
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
