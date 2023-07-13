import 'package:flutter/material.dart';

class ScheduleNotAvailable extends StatelessWidget {
  const ScheduleNotAvailable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.grid_off_outlined,
            color: Color.fromARGB(162, 158, 158, 158),
            size: 40,
          ),
          SizedBox(
            height: 8,
          ),
          Center(
            child: Text(
              'Jadwal Perkuliahan Belum Tersedia',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
