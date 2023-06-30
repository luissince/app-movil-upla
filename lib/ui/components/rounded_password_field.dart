import 'package:flutter/material.dart';
import 'package:upla/constants.dart';

import 'text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final TextEditingController text;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final FocusNode myFocusNode;
  final ValueChanged<String>? onSubmitted;
  final Function()? press;
  const RoundedPasswordField(
      {Key? key,
      required this.text,
      required this.obscureText,
      this.onChanged,
      required this.myFocusNode,
      this.onSubmitted,
      this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        focusNode: myFocusNode,
        controller: text,
        obscureText: obscureText,
        onChanged: onChanged,
        // onSubmitted: onSubmitted,
        onFieldSubmitted: onSubmitted,
        keyboardType: TextInputType.text,
        cursorColor: kPrimaryColor,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: "Contraseña",
          icon: const Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent, shadowColor: Colors.transparent),
            onPressed: press,
            child: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: kPrimaryColor,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
