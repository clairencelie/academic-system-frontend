import 'package:flutter/material.dart';

class RoomChoice extends StatefulWidget {
  final TextEditingController ruangan;
  const RoomChoice({
    super.key,
    required this.ruangan,
  });

  @override
  State<RoomChoice> createState() => _RoomChoiceState();
}

class _RoomChoiceState extends State<RoomChoice> {
  String? value;

  List<DropdownMenuItem> dropDownMenuList(List<String> rooms) {
    return rooms.map((room) {
      return DropdownMenuItem(
          value: room,
          child: Text(
            room,
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
            return 'Field pilihan ruangan belum terisi!';
          }
          return null;
        },
        decoration: const InputDecoration(
          hintText: 'Pilih ruangan...',
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
        value: (widget.ruangan.text == '') ? value : widget.ruangan.text,
        isExpanded: true,
        items: dropDownMenuList(
          [
            'A101',
            'A102',
            'A103',
            'B101',
            'B102',
            'B103',
            'B104',
            'C101',
            'C102',
            'C103',
            'D101',
            'D102',
            'D103',
            'Lab Komputer 1',
            'Lab Komputer 2',
            'Lab Komputer 3',
          ],
        ),
        onChanged: (value) {
          setState(() {
            widget.ruangan.text = value;
          });
        },
      ),
    );
  }
}
