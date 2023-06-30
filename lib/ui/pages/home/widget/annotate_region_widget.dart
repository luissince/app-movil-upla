import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnnotateRegionWidget {
  Widget children;

  AnnotateRegionWidget({required this.children});

  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: children,
      ),
    );
  }
}
