import 'package:flutter/material.dart';
import 'package:upla/constants.dart';

import 'text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final TextEditingController text;
  final String hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode myFocusNode;
  const RoundedInputField(
      {Key? key,
      required this.text,
      required this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      required this.myFocusNode,
      this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        focusNode: myFocusNode,
        controller: text,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        cursorColor: kPrimaryColor,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
