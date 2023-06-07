import 'package:flutter/material.dart';

class WebNoSchedule extends StatelessWidget {
  const WebNoSchedule({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
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
              'Jadwal Kosong',
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
