import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonHome extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final IconData icon;

  const ButtonHome({
    super.key,
    required this.onPressed,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // primary: Colors.white,
          backgroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 10,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: const Color.fromRGBO(41, 45, 67, 1),
                  size: 23,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color.fromRGBO(41, 45, 67, 1),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Icon(
              CupertinoIcons.chevron_right,
              color: Color.fromRGBO(41, 45, 67, 1),
              size: 23,
            ),
          ],
        ),
      ),
    );
  }
}
