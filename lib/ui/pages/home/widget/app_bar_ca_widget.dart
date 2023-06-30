import 'package:flutter/material.dart';
import 'package:upla/constants.dart';

class AppBarCaWidget {
  String title;

  AppBarCaWidget({required this.title});

  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: "Montserrat",
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }
}
