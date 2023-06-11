import 'package:flutter/material.dart';

class TimeField extends StatefulWidget {
  const TimeField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String? Function(String? value)? validator;

  @override
  State<TimeField> createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  TimeOfDay time = TimeOfDay.now();

  String getTimeText() {
    return '${time.hour}:${time.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: widget.hintText,
          errorStyle: const TextStyle(
            height: 1,
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          isDense: true,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(55, 112, 112, 112),
            ),
          ),
          filled: true,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(55, 112, 112, 112),
            ),
          ),
        ),
        onTap: () async {
          final newTime = await showTimePicker(
            context: context,
            initialTime: time,
          );
          if (newTime == null) return;
          setState(() {
            time = newTime;
            widget.controller.text = '${time.hour}:${time.minute}';
          });
        },
      ),
    );
  }
}
