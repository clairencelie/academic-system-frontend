import 'package:academic_system/src/constant/colors.dart';
import 'package:academic_system/src/model/schedule.dart';
import 'package:academic_system/src/ui/mobile/page/schedule_detail.dart';
import 'package:flutter/material.dart';

class SimpleScheduleCard extends StatelessWidget {
  final Schedule schedule;

  const SimpleScheduleCard({
    Key? key,
    required this.schedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScheduleDetailPage(jadwal: schedule),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: mainColor,
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: Color.fromARGB(55, 0, 0, 0),
              offset: Offset(0, 2),
            ),
          ],
        ),
        // height: 165,
        width: 185,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              schedule.learningSubName,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  schedule.grade,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${schedule.startsAt} - ${schedule.endsAt}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
