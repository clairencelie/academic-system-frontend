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
        SizedBox(
          width: 150,
          child: Text(
            'Kode Mata Kuliah',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 300,
          child: Text(
            'Nama Mata Kuliah',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 50,
          child: Text(
            'SKS',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 70,
          child: Text(
            'Kelas',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 120,
          child: Text(
            'Jenis',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
