import 'package:academic_system/src/model/krs_schedule.dart';
import 'package:academic_system/src/model/user.dart';
import 'package:academic_system/src/ui/mobile/page/all_schedule_page.dart';
import 'package:flutter/material.dart';

class AllScheduleCard extends StatelessWidget {
  final KrsSchedule krsSchedule;

  final User user;
  const AllScheduleCard({
    Key? key,
    required this.user,
    required this.krsSchedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AllSchedulePageMobile(krsSchedule: krsSchedule)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        // height: 170,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 7, 117, 207),
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
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: SizedBox(
                  width: 200,
                  child: Text(
                    'Cek Jadwal Perkuliahan Selengkapnya disini',
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Klik disini untuk selengkapnya',
                textAlign: TextAlign.end,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
