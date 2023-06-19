import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  final String title;
  final String body;
  final Function() onClose;

  const InfoDialog({
    Key? key,
    required this.title,
    required this.body,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          color: Color.fromARGB(255, 0, 32, 96),
        ),
      ),
      content: Text(
        body,
      ),
      actions: [
        TextButton(
          onPressed: onClose,
          child: const Text(
            'Tutup',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 32, 96),
            ),
          ),
        ),
      ],
    );
  }
}
