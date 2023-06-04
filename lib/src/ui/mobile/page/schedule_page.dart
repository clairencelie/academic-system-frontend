import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/mobile/component/card/all_schedule_card.dart';
import 'package:academic_system/src/ui/mobile/component/custom_widget/schedule_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SchedulePage extends StatelessWidget {
  final User user;

  const SchedulePage({super.key, required this.user});

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
                  AllScheduleCard(
                    user: user,
                  ),
                  ScheduleList(
                    user: user,
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
