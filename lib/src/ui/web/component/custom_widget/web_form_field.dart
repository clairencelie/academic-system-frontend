import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WebFormField extends StatelessWidget {
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textInputFormatter;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final String hintText;

  const WebFormField({
    Key? key,
    this.textInputType,
    this.textInputFormatter,
    this.controller,
    this.validator,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: TextFormField(
        validator: validator,
        controller: controller,
        keyboardType: textInputType,
        inputFormatters: textInputFormatter,
        cursorColor: const Color.fromARGB(255, 0, 32, 96),
        decoration: InputDecoration(
          hintText: hintText,
          errorStyle: const TextStyle(
            height: 0.7,
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
      ),
    );
  }
}
