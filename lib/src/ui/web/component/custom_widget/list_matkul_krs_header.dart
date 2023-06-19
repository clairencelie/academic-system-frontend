import 'package:flutter/material.dart';

class ListMatkulKrsHeader extends StatelessWidget {
  const ListMatkulKrsHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        SizedBox(
          width: 17,
        ),
        Expanded(
          // width: 150,
          child: Text(
            'Kode Mata Kuliah',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          // width: 300,
          flex: 2,
          child: Text(
            'Nama Mata Kuliah',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          // width: 100,
          child: Text(
            'SKS',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          // width: 100,
          child: Text(
            'Kelas',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          // width: 120,
          child: Text(
            'Jenis',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 50,
        ),
      ],
    );
  }
}
