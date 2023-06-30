import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeadBoardHome extends StatelessWidget {
  final Size size;
  final String docNumId;
  final double bottom;

  HeadBoardHome({
    required this.size,
    required this.docNumId,
    required this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottom),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            "assets/images/logo_upla.svg",
            height: 100,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            width: size.height * 0.08,
            height: size.height * 0.08,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                      "https://academico.upla.edu.pe/FotosAlum/037000${docNumId}.jpg"),
                  fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }
}
