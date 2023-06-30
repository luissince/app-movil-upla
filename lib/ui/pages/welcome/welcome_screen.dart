import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upla/ui/components/responsive.dart';
import 'package:upla/ui/pages/welcome/widget/welcome_desktop.dart';
import 'package:upla/ui/pages/welcome/widget/welcome_mobile.dart';

class WelcomeScreen extends StatelessWidget {
  static String id = "welcome_page";

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Responsive(
          mobile: WelcomeMobile(),
          tablet: WelcomeDesktop(),
          desktop: WelcomeDesktop(),
        ),
      ),
    );
  }
}
