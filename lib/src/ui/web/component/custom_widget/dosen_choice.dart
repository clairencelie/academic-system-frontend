import 'package:academic_system/src/bloc/user/user_bloc.dart';
import 'package:academic_system/src/model/lecturer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DosenChoice extends StatefulWidget {
  final TextEditingController dosenId;
  const DosenChoice({
    super.key,
    required this.dosenId,
  });

  @override
  State<DosenChoice> createState() => _DosenChoiceState();
}

class _DosenChoiceState extends State<DosenChoice> {
  String? value;

  List<DropdownMenuItem> dropDownMenuList(List<Lecturer> lecturers) {
    return lecturers.map((lecturer) {
      return DropdownMenuItem(
          value: lecturer.id.toString(),
          child: Text(
            lecturer.name,
            overflow: TextOverflow.ellipsis,
          ));
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetLecturer());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is LecturerFound) {
          return Padding(
            padding: const EdgeInsets.only(top: 5),
            child: DropdownButtonFormField(
              // validator: (value) {
              //   if (value == null) {
              //     return 'Field pilihan dosen belum terisi!';
              //   }
              //   return null;
              // },
              decoration: const InputDecoration(
                hintText: 'Pilih dosen...',
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
              value: (widget.dosenId.text == '') ? value : widget.dosenId.text,
              isExpanded: true,
              items: dropDownMenuList(state.lecturers),
              onChanged: null
              //  (value) {
              //   setState(() {
              //     widget.dosenId.text = value;
              //   });
              // }
              ,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
