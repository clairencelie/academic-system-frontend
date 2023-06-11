import 'package:flutter/material.dart';

class DayChoice extends StatefulWidget {
  final TextEditingController hari;
  const DayChoice({
    super.key,
    required this.hari,
  });

  @override
  State<DayChoice> createState() => _DayChoiceState();
}

class _DayChoiceState extends State<DayChoice> {
  String? value;

  List<DropdownMenuItem> dropDownMenuList(List<String> days) {
    return days.map((day) {
      return DropdownMenuItem(
          value: day,
          child: Text(
            day,
            overflow: TextOverflow.ellipsis,
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: DropdownButtonFormField(
        validator: (value) {
          if (value == null) {
            return 'Field pilihan hari belum terisi!';
          }
          return null;
        },
        decoration: const InputDecoration(
          hintText: 'Pilih hari...',
          errorStyle: TextStyle(
            height: 0.7,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          isDense: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(55, 112, 112, 112),
            ),
          ),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(55, 112, 112, 112),
            ),
          ),
        ),
        menuMaxHeight: 200,
        value: (widget.hari.text == '') ? value : widget.hari.text,
        isExpanded: true,
        items: dropDownMenuList(
          [
            'Senin',
            'Selasa',
            'Rabu',
            'Kamis',
            'Jumat',
          ],
        ),
        onChanged: (value) {
          setState(() {
            widget.hari.text = value;
          });
        },
      ),
    );
  }
}
