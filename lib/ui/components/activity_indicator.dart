import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityIndicator extends StatelessWidget {
  final Color color;
  final double? radius;
  final double? size;
  const ActivityIndicator(
      {Key? key, required this.color, this.radius = 15, this.size = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoActivityIndicator(radius: radius!, color: color);
    } else if (Platform.isAndroid) {
      return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(color: color),
      );
    } else {
      return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(color: color),
      );
    }
  }
}
