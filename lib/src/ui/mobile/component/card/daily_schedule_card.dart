import 'package:academic_system/src/model/schedule.dart';
import 'package:flutter/material.dart';

class DailyScheduleCard extends StatelessWidget {
  final Schedule schedule;
  const DailyScheduleCard({
    Key? key,
    required this.schedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String startsAt = schedule.startsAt.substring(0, 5);
    final String endsAt = schedule.endsAt.substring(0, 5);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return ScheduleDetailPage(
          //         schedule: schedule,
          //       );
          //     },
          //   ),
          // );
        },
        child: Container(
          // height: 100,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              children: [
                Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 224, 224, 224),
                    // image: const DecorationImage(
                    //   image: AssetImage('assets/img/avatar/default-avatar.jpg'),
                    // ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nama Mata Kuliah
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: SizedBox(
                              width: 150,
                              child: Text(
                                schedule.learningSubName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            schedule.grade,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // Nama Dosen
                      SizedBox(
                        width: 170,
                        child: Text(
                          'Dosen: ${schedule.lecturerName}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // Ruang
                      Text(
                        'Ruang: ${schedule.room}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '$startsAt - $endsAt',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
