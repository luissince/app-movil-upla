import 'package:flutter/material.dart';

class BackgroundHome extends StatelessWidget {
  final Widget child;
  final RefreshCallback onRefresh;
  const BackgroundHome({
    Key? key,
    required this.child,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(
            child: Center(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(73, 193, 225, 1),
                      Color.fromRGBO(0, 125, 188, 1),
                    ],
                  ),
                ),
              ),
            ),
          ),
          /**
           * 
           */
          Positioned(
            child: ClipPath(
              clipper: BackgroundClipper(),
              child: Container(
                width: size.width,
                height: size.height * 0.5,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(0, 125, 188, 1),
                      Color.fromRGBO(73, 193, 225, 1),
                    ],
                  ),
                ),
              ),
            ),
          ),
          /**
           * 
           */
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 90,
              height: 90,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Color.fromRGBO(204, 251, 240, 0.1),
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 15,
            child: Container(
              width: 60,
              height: 60,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Color.fromRGBO(204, 251, 240, 0.15),
              ),
            ),
          ),
          Positioned(
            left: 28,
            top: 28,
            child: Container(
              width: 34,
              height: 34,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Color.fromRGBO(110, 205, 190, 0.5),
              ),
            ),
          ),
          Positioned(
            left: 30,
            top: 30,
            child: Container(
              width: 30,
              height: 30,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Color.fromRGBO(226, 252, 246, 0.8),
              ),
            ),
          ),
          /**
           * 
           */
          Positioned(
            left: size.width * 0.30,
            top: size.height * 0.20,
            child: Container(
              width: 5,
              height: 5,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Color.fromRGBO(226, 252, 246, 0.5),
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.80,
            top: size.height * 0.20,
            child: Container(
              width: 5,
              height: 5,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Color.fromRGBO(226, 252, 246, 0.5),
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.90,
            top: size.height * 0.10,
            child: Container(
              width: 5,
              height: 5,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Color.fromRGBO(226, 252, 246, 0.5),
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.40,
            top: size.height * 0.10,
            child: Container(
              width: 5,
              height: 5,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Color.fromRGBO(226, 252, 246, 0.5),
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.20,
            top: size.height * 0.10,
            child: Container(
              width: 5,
              height: 5,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Color.fromRGBO(226, 252, 246, 0.5),
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.10,
            top: size.height * 0.35,
            child: Container(
              width: 5,
              height: 5,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Color.fromRGBO(226, 252, 246, 0.5),
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.30,
            top: size.height * 0.26,
            child: Container(
              width: 5,
              height: 5,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Color.fromRGBO(226, 252, 246, 0.5),
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.60,
            top: size.height * 0.25,
            child: Container(
              width: 5,
              height: 5,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Color.fromRGBO(226, 252, 246, 0.5),
              ),
            ),
          ),
          Positioned(
            left: size.width * 0.90,
            top: size.height * 0.30,
            child: Container(
              width: 5,
              height: 5,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Color.fromRGBO(226, 252, 246, 0.5),
              ),
            ),
          ),
          /**
           * 
           */
          Positioned(
            left: 0,
            top: size.height * 0.3,
            child: Container(
              width: 60,
              height: 10,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 125, 188, 0.5),
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
          Positioned(
            left: size.width * 0.30,
            top: size.height * 0.25,
            child: Container(
              width: 60,
              height: 10,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 125, 188, 0.5),
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
          Positioned(
            left: size.width * 0.60,
            top: size.height * 0.30,
            child: Container(
              width: 60,
              height: 10,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 125, 188, 0.5),
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
          Positioned(
            left: size.width * 0.90,
            top: size.height * 0.25,
            child: Container(
              width: 60,
              height: 10,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 125, 188, 0.5),
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
          /**
           * 
           */
          /**
           * 
           */
          SafeArea(
            child: RefreshIndicator(
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);

    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
